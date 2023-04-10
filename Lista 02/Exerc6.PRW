#include "PROTHEUS.CH"

USER FUNCTION L2_E6()
    Local nNum_1 := 0 
    Local nNum_2 := 0
    Local nNum_3 := 0
    Local nNum_4 := 0

    nNum_1 := Val(FWINPUTBOX("Digite um número"))
    nNum_2 := Val(FWINPUTBOX("Digite um número"))
    nNum_3 := Val(FWINPUTBOX("Digite um número"))
    nNum_4 := Val(FWINPUTBOX("Digite um número"))

    if(nNum_1 % 2 ==0 ).and. (nNum_1 % 3 ==0)
        MSGALERT("o valor digitado " +alltrim(str(nNum_1)) + " é divisível por 2 e 3")
    else
        MSGALERT("o valor digitado " +alltrim(str(nNum_1)) + " não é divisível por 2 e 3")
    ENDIF

    if(nNum_2 % 2 ==0 ).and. (nNum_2 % 3 ==0)
        MSGALERT("o valor digitado " + alltrim(str(nNum_2)) + " é divisível por 2 e 3")
    else
        MSGALERT("o valor digitado " + alltrim(str(nNum_2)) + " não é divisível por 2 e 3")
    ENDIF

    if(nNum_3 % 2 ==0 ).and. (nNum_3 % 3 ==0)
        MSGALERT("o valor digitado "+alltrim(str(nNum_3)) + " é divisível por 2 e 3")
    else
        MSGALERT("o valor digitado " + alltrim(str(nNum_3)) + " não é divisível por 2 e 3")
    ENDIF

    if(nNum_4 % 2 ==0 ).and. (nNum_4 % 3 ==0)
        MSGALERT("o valor digitado " + alltrim(str(nNum_4)) + " é divisível por 2 e 3")
    else
        MSGALERT("o valor digitado " + alltrim(str(nNum_4)) +  " não é divisível por 2 e 3")
    ENDIF

RETURN NIL
