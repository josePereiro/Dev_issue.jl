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

println("\nDeveloping MyPkg ------------------------\n")
cd("..")
# Now in Tests
Pkg.activate(".")
Pkg.develop(Pkg.PackageSpec(path="./MyPkg"))

println("\nProject.toml\n", read("Project.toml", String))
println("\nManifest.toml\n", read("Manifest.toml", String))

println("\nAdding MyPkg ------------------------\n")
rm("Project.toml")
rm("Manifest.toml")
Pkg.add(Pkg.PackageSpec(path="./MyPkg"))

println("\nProject.toml\n", read("Project.toml", String))
println("\nManifest.toml\n", read("Manifest.toml", String))

# clear
atexit() do
    cd(rootfolder)
    rm("Test", recursive = true, force = true)
end