package prompt

const (
	BASH_TYPE = iota + 1
	SYSTEM_PACKAGE_MANAGER
)

type Program struct {
	Package string
	Type    int
	Path    string
}

func NewProgramBash(name, path string) Program {
	return Program{
		Package: name,
		Type:    BASH_TYPE,
		Path:    path,
	}
}

func NewProgramPackageManager(name string) Program {
	return Program{
		Package: name,
		Type:    SYSTEM_PACKAGE_MANAGER,
	}
}
