package main

import (
	"bytes"
	"fmt"
	"log"
	"os/exec"

	"gopkg.in/AlecAivazis/survey.v1"
)

func main() {
	programs := []string{}
	prompt := &survey.MultiSelect{
		Message: "Que deseas instalar?",
		Options: []string{"vim", "emacs", "go", "zsh"},
	}
	survey.AskOne(prompt, &programs, nil)

	autoinstall(programs)
}

func autoinstall(programs []string) {
	distro := "Ubuntu"
	install(distro, programs)
}

func install(distro string, programs []string) {
	var cmd *exec.Cmd

	args := []string{"apt-get", "install", "-y"}
	args = append(args, programs...)

	fmt.Print(args)
	if "Ubuntu" == distro {
		cmd = exec.Command("sudo", args...)
	} else if "Fedora" == distro {
		cmd = exec.Command("dnf", programs...)
	}

	var outbuf, errbuf bytes.Buffer
	cmd.Stdout = &outbuf
	cmd.Stderr = &errbuf

	err := cmd.Run()
	stdout := outbuf.String()

	log.Printf("command result, stdout: %v, stderr: %v, exitCode: %v", stdout, errbuf.String(), err)
	return
}
