package prompt

import (
	"bytes"
	"log"
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
	cmd.Stdout = &outbuf
	cmd.Stderr = &errbuf

	err := cmd.Run()
	stdout := outbuf.String()

	log.Printf("\n%v\n", stdout)

	if err != nil {
		log.Printf("\nStdout: %v\n\n ExitCode: %v", errbuf.String(), err)
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
