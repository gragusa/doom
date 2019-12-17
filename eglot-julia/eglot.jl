import Pkg
Pkg.activate(@__DIR__)

using LanguageServer

server = LanguageServer.LanguageServerInstance(stdin, stdout, false,
                                               ARGS[1], ARGS[2], Dict())
run(server)