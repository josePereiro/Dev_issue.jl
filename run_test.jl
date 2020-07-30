rm("Test", recursive = true, force = true) # clear
rootfolder = pwd()

import InteractiveUtils: versioninfo
println("\nversioninfo ------------------------")
versioninfo()

println("\nCreate Test Project and MyPkg ------------------------\n")
mkdir("Test")
cd("Test")

import Pkg
Pkg.generate("MyPkg")

cd("MyPkg")
run(`git init`)
run(`git add .`)
run(`git commit -m "First commit"`)

println("\nDeveloping local MyPkg ------------------------\n")
cd("..")
# Now in Tests
Pkg.activate(".")
Pkg.develop(Pkg.PackageSpec(path="./MyPkg"))

println("\nTest enviroment state")
println("\nProject.toml\n", read("Project.toml", String))
println("\nManifest.toml\n", read("Manifest.toml", String))

println("\nAdding local MyPkg ------------------------\n")
rm("Project.toml")
rm("Manifest.toml")
Pkg.add(Pkg.PackageSpec(path="./MyPkg"))

println("\nTest enviroment state")
println("\nProject.toml\n", read("Project.toml", String))
println("\nManifest.toml\n", read("Manifest.toml", String))

println("\nDeveloping registered Example.jl ------------------------\n")
rm("MyPkg"; recursive = true, force = true)
rm("Project.toml")
rm("Manifest.toml")
Pkg.develop("Example")

println("\nTest enviroment state")
println("\nProject.toml\n", read("Project.toml", String))
println("\nManifest.toml\n", read("Manifest.toml", String))

println("\nAdding registered Example.jl ------------------------\n")
rm("Project.toml")
rm("Manifest.toml")
Pkg.add("Example")

println("\nTest enviroment state")
println("\nProject.toml\n", read("Project.toml", String))
println("\nManifest.toml\n", read("Manifest.toml", String))

# clear
atexit() do
    cd(rootfolder)
    rm("Test", recursive = true, force = true)
end