// Integrante: Fernando Gentil Pinheiro Pacheco - 122110631

// Conjunto de Perfis que tem na midia social
sig Perfil{
    usuario: one Usuario,
    posts : set Posts
}

// Conjunto de Usuarios
sig Usuario {
    perfis : set Perfil,
    amigos : set Usuario,
    naoAmigos: set Usuario
}

// Conjunto de Posts
sig Posts {
    criador : one Usuario
}

// Conjunto de Usuarios ativos
one sig Ativo {
    usuarios: set Usuario,
    perfis: set Perfil
}

// Conjunto de usuarios inativos
one sig Inativo {
    usuarios: set Usuario,
    perfis: set Perfil
}

// Uma restriçao que determina se o usuario eh ativo ou inativo
fact "usuario ativo ou inativo"  {
    all a:Ativo, i:Inativo, u:Usuario | ((u in a.usuarios) and !(u in i.usuarios)) or ((u in i.usuarios) and !(u in a.usuarios))
}

// Uma restriçao que determina se o perfil eh ativo ou inativo
fact "perfil ativo ou inativo" {
    all a:Ativo, i:Inativo, p:Perfil | ((p in a.perfis) and !(p in i.perfis)) or (!(p in a.perfis) and (p in i.perfis))
}

// Uma restriçao que determina que o criador pode publicar tanto em seu perfil quanto no perfil de amigos
fact "criador pode publicar em perfil de amigo e em seu perfil" {
    all u: Usuario, p: Posts, per: Perfil | 
        (p.criador in u.amigos or p.criador = per.usuario) implies (p in per.posts)
}

// Uma restricao que garante que os usuários não podem ser amigos de si mesmos
fact "usuários não podem ser amigos de si mesmos" {
    no u: Usuario | u in u.amigos
}

// uma retricao em que um usuário não pode ser amigo e não amigo de outro ao mesmo tempo
fact "um usuário não pode ser amigo e não amigo de outro ao mesmo tempo" {
  all u1: Usuario, u2: Usuario | !((u1 in u2.amigos) and (u1 in u2.naoAmigos))
}

// Restrição: As postagens devem estar associadas a usuários ativos
fact "postagens associadas a usuários ativos" {
  all p: Posts | (p.criador in Ativo.usuarios) and !(p.criador in Inativo.usuarios) 
}

// Verificando se tem amigos que sao nao amigos
assert amigosSaoNaoAmigos {
  all u: Usuario | u.amigos & u.naoAmigos = none
}

// Checando se tem amigos que sao nao amigos
check amigosSaoNaoAmigos


run{}
