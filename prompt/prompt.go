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

func install(distro *Distro, programs []string) {
	var cmd *exec.Cmd

	args := []string{"install", "-y"}

	args = append(args, programs...)

	cmd = exec.Command(distro.PackageManager, args...)

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
	distro, err := getDistro()
	if err != nil {
		log.Fatal(err)
	}

	listPackages := []Program{}
	listOptionsPackages := []string{}
	for i := range p.Recipe.Special.Bash {
		listOptionsPackages = append(listOptionsPackages, fmt.Sprintf("%s - bash", i))
		listPackages = append(listPackages, *NewProgramBash(i))
	}

	for _, v := range p.Recipe.Packages {
		listOptionsPackages = append(listOptionsPackages, fmt.Sprintf("%s - %s", v, distro.PackageManager))
		listPackages = append(listPackages, *NewProgramPackageManager(v))
	}

	programs := []string{}
	prompt := &survey.MultiSelect{
		Message: "¿Qué deseas instalar?",
		Options: listOptionsPackages,
		VimMode: true,
	}

	survey.AskOne(prompt, &programs, nil)

	if len(programs) > 0 {
		install(distro, programs)
	}
}
