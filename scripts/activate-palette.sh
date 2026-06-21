#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
palette_dir="$repo_dir/palettes"
active_dir="${XDG_DATA_HOME:-$HOME/.local/share}/org.gnome.Ptyxis/palettes"

mkdir -p "$active_dir"

mapfile -t palettes < <(find "$palette_dir" -maxdepth 1 -type f -name '*.palette' -printf '%f\n' | sort)

if [[ "${1-}" == "--list" ]]; then
  printf '%s\n' "${palettes[@]}" | sed 's/\.palette$//'
  exit 0
fi

choice="${1-}"
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

profiles_raw="$(gsettings get org.gnome.Ptyxis profile-uuids)"
profiles="$(printf '%s' "$profiles_raw" | tr -d "[],'")"
uuid=""

for id in $profiles; do
  label="$(gsettings get "org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/$id/" label | sed "s/^'//; s/'$//")"
  if [[ "$label" == "$choice" ]]; then
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
gsettings set "$schema" label "$choice"
gsettings set "$schema" palette "$choice"
gsettings set "$schema" opacity 1.0
gsettings set "$schema" bold-is-bright true
gsettings set org.gnome.Ptyxis default-profile-uuid "$uuid"

printf 'Activated %s\n' "$choice"
