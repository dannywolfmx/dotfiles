package prompt

import (
	"errors"
	"os/exec"
	"strings"
)

type Distro struct {
	Name, PackageManager string
}

var Distros = map[string]*Distro{
	"Ubuntu": {
		Name:           "Ubuntu",
		PackageManager: "apt-get",
	},
	"Fedora": {
		Name:           "Fedora",
		PackageManager: "dnf",
	},
}

//Todo check if fedora uses the "uname -a" command
func getDistro() (*Distro, error) {
	out, err := exec.Command("uname", "-a").Output()

	if err != nil {
		return nil, err
	}

	for key := range Distros {
		if strings.Contains(string(out), key) {
			return Distros[key], nil
		}
	}

	return nil, errors.New("Distro no soportada")
}
