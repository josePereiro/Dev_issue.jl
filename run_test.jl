rm("Test", recursive = true, force = true) # clear
rootfolder = pwd()

import InteractiveUtils: versioninfo
println("versioninfo")
versioninfo()

println("\nCreate Test Project and MyPkg to dev\n")
mkdir("Test")
cd("Test")

import Pkg
Pkg.generate("MyPkg")

cd("MyPkg")
run(`git init`)
run(`git add .`)
run(`git commit -m "First commit"`)

cd("..")
# Now in Tests
Pkg.activate(".")
Pkg.develop(Pkg.PackageSpec(path="./MyPkg"))

println("\n\nTest enviroment\n")
println("Project.toml\n", read("Project.toml", String), "\n")
println("Manifest.toml\n", read("Manifest.toml", String), "\n")

# clear
atexit() do
    cd(rootfolder)
    rm("Test", recursive = true, force = true)
end