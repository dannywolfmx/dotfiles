package prompt

import (
	"os"

	"gopkg.in/yaml.v2"
)

type Recipe struct {
	Install
}

type Install struct {
	Packages []string `yaml:"packages"`
	Special  struct {
		Bash map[string]string `yaml:"bash"`
	}
}

func ReadRecipeFile(path string) (*Recipe, error) {
	file, err := os.ReadFile(path)
	if err != nil {
		return nil, err
	}

	recipe := &Recipe{}
	if err := yaml.Unmarshal(file, recipe); err != nil {
		return nil, err
	}

	return recipe, nil
}
