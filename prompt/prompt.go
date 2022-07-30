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

func install(distro *Distro, programs []Program) {

	argsSystemPackageManager := []string{"install", "-y"}

	argsBash := []string{}

	//Trabajar con apt-get
	for _, program := range programs {
		if program.Type == SYSTEM_PACKAGE_MANAGER {
			argsSystemPackageManager = append(argsSystemPackageManager, program.Package)
		} else if program.Type == BASH_TYPE {
			argsBash = append(argsBash, program.Path)
		}
	}

	if err := installPackageManager(distro.PackageManager, argsSystemPackageManager); err != nil {
		fmt.Printf("Error al instalar packages con el package manager: %s \n", err)
	}

	if err := installBash(argsBash); err != nil {
		fmt.Printf("Error al instalar packages con el package manager: %s \n", err)
	}

}

func installPackageManager(packageManager string, args []string) error {
	if len(args) <= 2 {
		return nil
	}

	fmt.Println("**** Installing package manager ***")

	var cmd *exec.Cmd

	cmd = exec.Command(packageManager, args...)

	var outbuf, errbuf bytes.Buffer
	cmd.Stdout = io.MultiWriter(os.Stdout, &outbuf)
	cmd.Stderr = io.MultiWriter(os.Stderr, &errbuf)

	return cmd.Run()
}

func installBash(args []string) error {
	fmt.Println(args)
	if len(args) == 0 {
		return nil
	}

	fmt.Println("**** Installing bash ***")
	var cmd *exec.Cmd

	cmd = exec.Command("/bin/sh", args...)

	var outbuf, errbuf bytes.Buffer
	cmd.Stdout = io.MultiWriter(os.Stdout, &outbuf)
	cmd.Stderr = io.MultiWriter(os.Stderr, &errbuf)

	return cmd.Run()
}

func (p *Prompt) Show() {
	distro, err := getDistro()
	if err != nil {
		log.Fatal(err)
	}

	listPackages := []Program{}
	listOptionsPackages := []string{}
	for i, path := range p.Recipe.Special.Bash {
		listOptionsPackages = append(listOptionsPackages, fmt.Sprintf("%s - bash", i))
		listPackages = append(listPackages, NewProgramBash(i, path))
	}

	for _, v := range p.Recipe.Packages {
		listOptionsPackages = append(listOptionsPackages, fmt.Sprintf("%s - %s", v, distro.PackageManager))
		listPackages = append(listPackages, NewProgramPackageManager(v))
	}

	selectedOptions := []int{}
	prompt := &survey.MultiSelect{
		Message: "¿Qué deseas instalar?",
		Options: listOptionsPackages,
		VimMode: true,
	}

	survey.AskOne(prompt, &selectedOptions, nil)

	programs := []Program{}

	for _, v := range selectedOptions {
		programs = append(programs, listPackages[v])
	}

	if len(programs) > 0 {
		install(distro, programs)
	}
}
