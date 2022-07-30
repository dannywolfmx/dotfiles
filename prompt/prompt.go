package prompt

import (
	"bytes"
	"fmt"
	"io"
	"log"
	"os"
	"os/exec"

	"github.com/AlecAivazis/survey/v2"
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
	listPackages := []string{}
	for i := range p.Recipe.Special.Bash {
		listPackages = append(listPackages, fmt.Sprintf("%s - bash", i))
	}
	for _, v := range p.Recipe.Packages {
		listPackages = append(listPackages, fmt.Sprintf("%s - apt-get", v))
	}

	programs := []int{}
	prompt := &survey.MultiSelect{
		Message: "¿Qué deseas instalar?",
		Options: listPackages,
		VimMode: true,
	}
	survey.AskOne(prompt, &programs, nil)

	fmt.Println("Programas: ", programs)
	if len(programs) > 0 {
		fmt.Print(programs)
		//install("Ubuntu", programs)
	}
}
