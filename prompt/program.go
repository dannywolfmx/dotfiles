package prompt

const (
	BASH_TYPE = iota + 1
	SYSTEM_PACKAGE_MANAGER
)

type Program struct {
	Package string
	Type    int
}

func NewProgramBash(name string) *Program {
	return &Program{
		Package: name,
		Type:    BASH_TYPE,
	}
}

func NewProgramPackageManager(name string) *Program {
	return &Program{
		Package: name,
		Type:    SYSTEM_PACKAGE_MANAGER,
	}
}
