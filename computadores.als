/**
Apenas 1 deles é o ideal.
1. Apenas 3 são rápidos, apenas 2 tem boa memória, apenas um é
compacto.
2. Todas quatro marcas possuem pelo menos uma das características
3. Lenovo e Dell têm a mesma capacidade de memória.
4. Dell e Apple são igualmente rápidos.
5. Apenas um entre Apple e Acer é considerado rápido. 
*/

//abstract: ?
//sig: "conjunto" de objetos
abstract sig Computador{}

sig Rapido, BoaMemoria, Compacto in Computador{}

one sig APPLE, DELL, LEN, ACER extends Computador{}

pred ideal[c:Computador] {
    //Conjunção: and ou &&
    (c in Rapido) and (c in BoaMemoria) and (c in Compacto)
}

fact "restrições do problema" {
    //1. Apenas 3 são rápidos, apenas 2 tem boa memória, apenas um é compacto
    one x:Computador | ideal[x]

    (#Rapido=3) and (#BoaMemoria=2) and (#Compacto=1)

    //2. Todas quatro marcas possuem pelo menos uma das características
    all c:Computador | (c in Rapido) or (c in BoaMemoria) or (c in Compacto)

    (LEN in BoaMemoria) <=> (DELL in BoaMemoria)
    (DELL in Rapido) <=> (APPLE in Rapido)
    ((APPLE in Rapido) and (ACER not in Rapido)) or ((ACER in Rapido) and (APPLE not in Rapido))
}

//#Computador maior que 1, esse 1 é o tamanho do computador
//run{#Computador > 1}

run{}