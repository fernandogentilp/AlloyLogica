sig Local {
    recursos: set Recurso,
    usuarios: set Usuario
}

sig Recurso {
    superior: lone Recurso
}

sig Usuario {
    acessa: set Recurso
}

fact "usuario nao compartilhado" {
    all u:Usuario | one l:Local | u in l.usuarios
}

fact "recurso nao compartilhado" {
    all r:Recurso | one l:Local | r in l.recursos
}

fact "usuarios acessam hierarquia"{
    all u:Usuario, r:Recurso | r in u.acessa implies inferiores[r] in u.acessa  
}

fact "sem ciclos" {
    all r:Recurso | r not in r.^superior
}

fun inferiores[r:Recurso]: set Recurso {
    {r1: Recurso | r in r1.^superior}
}

assert recursoNaoCompartilhado{
    !(some r:Recurso | #(recursos.r) > 1)
}

check recursoNaoCompartilhado

run{} for 5 but exactly 2 Local