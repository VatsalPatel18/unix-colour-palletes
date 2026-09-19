#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
palette_dir="$repo_dir/palettes"
active_dir="${XDG_DATA_HOME:-$HOME/.local/share}/org.gnome.Ptyxis/palettes"

mkdir -p "$active_dir"

mapfile -t palettes < <(find "$palette_dir" -maxdepth 1 -type f -name '*.palette' -printf '%f\n' | sort)

usage() {
  printf 'Usage: %s [PALETTE] [--glass]\n' "${0##*/}"
  printf '       %s --list\n' "${0##*/}"
}

choice=""
glass=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --list)
      if [[ $# -ne 1 ]]; then
        usage >&2
        exit 1
      fi
      printf '%s\n' "${palettes[@]}" | sed 's/\.palette$//'
      exit 0
      ;;
    --glass)
      glass=true
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --*)
      printf 'Unknown option: %s\n' "$1" >&2
      usage >&2
      exit 1
      ;;
    *)
      if [[ -n "$choice" ]]; then
        printf 'Only one palette may be selected.\n' >&2
        usage >&2
        exit 1
      fi
      choice="$1"
      ;;
  esac
  shift
done

if [[ -z "$choice" ]]; then
  printf 'Available palettes:\n'
  select item in "${palettes[@]}"; do
    if [[ -n "${item-}" ]]; then
      choice="${item%.palette}"
      break
    fi
  done
fi

src="$palette_dir/$choice.palette"
if [[ ! -f "$src" ]]; then
  echo "Unknown palette: $choice" >&2
  exit 1
fi

cp "$src" "$active_dir/"

opacity=1.0
profile_label="$choice"

# GLASS-WATER is the water-tinted preset; --glass applies the same effect to any palette.
if [[ "$choice" == "GLASS-WATER" ]]; then
  glass=true
fi

if [[ "$glass" == true ]]; then
  opacity=0.78
  if [[ "$choice" != "GLASS-WATER" ]]; then
    profile_label="${choice}-GLASS"
  fi
fi

profiles_raw="$(gsettings get org.gnome.Ptyxis profile-uuids)"
profiles="$(printf '%s' "$profiles_raw" | tr -d "[],'")"
uuid=""

for id in $profiles; do
  label="$(gsettings get "org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/$id/" label | sed "s/^'//; s/'$//")"
  if [[ "$label" == "$profile_label" ]]; then
    uuid="$id"
    break
  fi
done

if [[ -z "$uuid" ]]; then
  uuid="$(uuidgen | tr -d '-' | tr '[:upper:]' '[:lower:]')"
  if [[ -n "$profiles" ]]; then
    list="["
    first=1
    for id in $profiles; do
      if [[ $first -eq 1 ]]; then
        list="${list}'${id}'"
        first=0
      else
        list="${list}, '${id}'"
      fi
    done
    list="${list}, '${uuid}']"
  else
    list="['${uuid}']"
  fi
  gsettings set org.gnome.Ptyxis profile-uuids "$list"
fi

schema="org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/$uuid/"
gsettings set "$schema" label "$profile_label"
gsettings set "$schema" palette "$choice"
gsettings set "$schema" opacity "$opacity"
gsettings set "$schema" bold-is-bright true
gsettings set org.gnome.Ptyxis default-profile-uuid "$uuid"

printf 'Activated %s using palette %s (opacity %s)\n' "$profile_label" "$choice" "$opacity"
