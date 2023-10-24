/** Três fazendeiros que compartilharam uma mula por um
tempo discutem quem é o verdadeiro dono do animal.
No entanto, pessoalmente nenhum deles quer se
responsabilizar pela mula. Os três fazem as seguintes
declarações, em que uma é verdadeira e outra é falsa.

A
    1. A mula é de C.
    2. Não posso ser o dono.
B
    1. C não é o dono.
    2. A mula é de A.
C
    1. A mula é minha.
    2. A segunda declaração de B é falsa
De quem é a mula, afinal?
*/

abstract sig Fazendeiros{}

sig A, B, C in Fazendeiros{}

one sig MULA extends Fazendeiros{}

pred dono[f:Fazendeiros] {
    (MULA in f)
}

fact "restrições do problema mula" {
    one x : Fazendeiros | dono[x]

    !(MULA in C) <=> (MULA not in A)
    !(MULA not in C) <=> (MULA in A)
    !(MULA in C) <=> !(MULA in A)
}

run{}