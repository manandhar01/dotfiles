#!/usr/bin/env bash

pkill -x wofi

choose_device() {
    type="$1"

    case "$type" in
    AudioSink)
        class="Audio/Sink"
        default_key="default.audio.sink"
        ;;
    AudioSource)
        class="Audio/Source"
        default_key="default.audio.source"
        ;;
    VideoSink)
        class="Video/Sink"
        default_key="default.video.sink"
        ;;
    VideoSource)
        class="Video/Source"
        default_key="default.video.source"
        ;;
    esac

    default_name=$(pw-dump | jq -r '.[] | select(.type == "PipeWire:Interface:Metadata" and .props."metadata.name" == "default") | .metadata[] | select(.key == "'"$default_key"'") | .value.name')
    active_id=$(pw-dump | jq -r --arg name "$default_name" '.[] | select(.type == "PipeWire:Interface:Node" and .info.props."node.name" == $name) | .id')

    if [ -z "$active_id" ]; then
        active_id=""
    fi

    menu=$(pw-dump | jq -r --arg class "$class" '
      .[]
      | select(.type == "PipeWire:Interface:Node")
      | select(.info.props."media.class" == $class)
      | select(.info.props."node.description" != null)
      | "\(.id) \(.info.props."node.description")"
    ' | while read -r id desc; do
        mark=""
        if [[ "$id" == "$active_id" ]]; then
            mark="✓ "
        fi
        printf "%s%s %s\n" "$mark" "$id" "$desc"
    done)

    if [ -z "$menu" ]; then
        echo "No $type devices found." >&2
        exit 1
    fi

    choice=$(printf "%s\n" "$menu" | wofi --dmenu --prompt "Select $type")
    if [ -z "$choice" ]; then
        echo "No device selected." >&2
        exit 1
    fi

    id=$(echo "$choice" | awk '
        {
            for (i=1; i<=NF; i++) {
                if ($i ~ /^[0-9]+$/) {
                    print $i
                    exit
                }
            }
        }')

    if [ -z "$id" ]; then
        echo "Error: Could not extract ID from '$choice'" >&2
        exit 1
    fi

    echo "$id"
}

choice=$(printf "Audio Sink\nAudio Source\nVideo Sink\nVideo Source" | wofi --dmenu --prompt "Select category")

case "$choice" in
"Audio Sink")
    id=$(choose_device "AudioSink")
    if [ -n "$id" ]; then
        desc=$(pw-dump | jq -r --arg id "$id" '.[] | select(.type == "PipeWire:Interface:Node" and .id == ($id | tonumber)) | .info.props."node.description"')
        if wpctl set-default "$id"; then
            notify-send "Device Selection" "Selected Audio Sink: $desc"
        else
            notify-send "Device Selection" "Failed to set Audio Sink: $desc"
            exit 1
        fi
    fi
    ;;
"Audio Source")
    id=$(choose_device "AudioSource")
    if [ -n "$id" ]; then
        desc=$(pw-dump | jq -r --arg id "$id" '.[] | select(.type == "PipeWire:Interface:Node" and .id == ($id | tonumber)) | .info.props."node.description"')
        if wpctl set-default "$id"; then
            notify-send "Device Selection" "Selected Audio Source: $desc"
        else
            notify-send "Device Selection" "Failed to set Audio Source: $desc"
            exit 1
        fi
    fi
    ;;
"Video Sink")
    id=$(choose_device "VideoSink")
    if [ -n "$id" ]; then
        desc=$(pw-dump | jq -r --arg id "$id" '.[] | select(.type == "PipeWire:Interface:Node" and .id == ($id | tonumber)) | .info.props."node.description"')
        if wpctl set-default "$id"; then
            notify-send "Device Selection" "Selected Video Sink: $desc"
        else
            notify-send "Device Selection" "Failed to set Video Sink: $desc"
            exit 1
        fi
    fi
    ;;
"Video Source")
    id=$(choose_device "VideoSource")
    if [ -n "$id" ]; then
        desc=$(pw-dump | jq -r --arg id "$id" '.[] | select(.type == "PipeWire:Interface:Node" and .id == ($id | tonumber)) | .info.props."node.description"')
        if wpctl set-default "$id"; then
            notify-send "Device Selection" "Selected Video Source: $desc"
        else
            notify-send "Device Selection" "Failed to set Video Source: $desc"
            exit 1
        fi
    fi
    ;;
esac
