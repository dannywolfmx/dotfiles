package main

import "gopkg.in/AlecAivazis/survey.v1"

func main() {
	text := ""
	prompt := &survey.Multiline{
		Message: "ping",
	}
	survey.AskOne(prompt, &text, nil)
}
