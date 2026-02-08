{{ if eq .chezmoi.os "linux" -}}
#!/bin/sh

{{ else if eq .chezmoi.os "darwin" -}}
#!/bin/sh

{{ end -}}