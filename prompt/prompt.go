package prompt

import (
	"bytes"
	"io"
	"log"
	"os"
	"os/exec"

	"gopkg.in/AlecAivazis/survey.v1"
)

type Prompt struct {
	Recipe *Recipe
}

func NewPrompt(recipe *Recipe) *Prompt {
	return &Prompt{
		Recipe: recipe,
	}
}

func install(distro string, programs []string) {
	var cmd *exec.Cmd

	args := []string{"install", "-y"}

	args = append(args, programs...)

	if "Ubuntu" == distro {
		cmd = exec.Command("apt-get", args...)
	} else if "Fedora" == distro {
		cmd = exec.Command("dnf", programs...)
	}

	var outbuf, errbuf bytes.Buffer
	cmd.Stdout = io.MultiWriter(os.Stdout, &outbuf)
	cmd.Stderr = io.MultiWriter(os.Stderr, &errbuf)

	err := cmd.Run()

	if err != nil {
		log.Printf("\nExitCode: %v\n", err)
	}

	return
}

func (p *Prompt) Show() {
	programs := []string{}
	prompt := &survey.MultiSelect{
		Message: "Que deseas instalar?",
		Options: p.Recipe.Packages,
	}
	survey.AskOne(prompt, &programs, nil)

	distro := "Ubuntu"
	install(distro, programs)
}
