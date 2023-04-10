#INCLUDE 'PROTHEUS.CH'

/*/{Protheus.doc} L4_E9
    9 – Desenvolva um programa para calcular a TMB
(Taxa Metabólica Basal) de um indivíduo. A fórmula
para calcular a TMB de homens, é diferente da
fórmula para mulheres. As fórmulas são:
o Para Homens:
? TMB = 66.5 + (13.75 * peso) + (5.003 *
altura em cm) – (6.75 * idade)

o Para Mulheres:
? TMB = 655.1 + (9.563 * peso) + (1.850 *
altura em cm) – (4.676 * idade)
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/03/2023
    @version version
    @param 
    @return 
    @example
    (examples)
    @see (links_or_references)
    /*/

USER FUNCTION L4_E9()
    LOCAL nPeso   := Space(20)
    LOCAL nIdade  := Space(20)
    LOCAL cSex    := Space(1)
    LOCAL nAltura := Space(20)
    Local cPerg4  := 'Digite Sexo'
    LOCAL cPerg1  := 'Digite o peso: '
    LOCAL cPerg2  := 'Digite a idade: '
    LOCAL cPerg3  := 'Digite a altura'
    LOCAL cTitle  := 'Calculadora TMB'
    LOCAL cResul  := ' Ver reajuste'
    LOCAL cSair   := '    Sair     '
    LOCAL oDlg    := NIL
    LOCAL nOpcao  := 0
    Private oDlgPvt  := NIL
    Private nJanLarg := 200
    Private nJanAltu := 300


    DEFINE MSDIALOG oDlg  TITLE cTitle from 000, 000 to nJanLarg, nJanAltu PIXEL
    @ 010, 010 SAY cPerg1   SIZE 55, 77 OF oDLG PIXEL
    @ 025, 010 SAY cPerg2   SIZE 55, 77 OF oDlg PIXEL
    @ 040, 010 SAY cPerg3   SIZE 55, 77 OF oDlg PIXEL
    @ 055, 010 SAY cPerg4   SIZE 55, 77 OF oDlg PIXEL PICTURE '@A'


    @ 010, 065 MSGET nPeso   SIZE 55, 11 OF oDlg PIXEL
    @ 025, 065 MSGET nIdade  SIZE 55, 11 OF oDlg PIXEL 
    @ 040, 065 MSGET nAltura SIZE 55, 11 OF oDlg PIXEL 
    @ 055, 065 MSGET cSex    SIZE 55, 11 OF oDlg PIXEL 

    @ 070, 010 BUTTON oBtnConf PROMPT cResul SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 1, oDlg:End()) PIXEL
    @ 080, 010 BUTTON oBtnConf PROMPT cSair  SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 2, oDlg:End()) PIXEL
    
    ACTIVATE MSDIALOG oDlg CENTERED

     if nOpcao == 1
        tmb(nIdade, nPeso, cSex, nAltura)

    else
        FwAlertError('Cancelado pelo usuário!', 'Cancelado!')
    endif
Return


STATIC FUNCTION tmb(nIdade, nPeso, cSex, nAltura)
    LOCAL nTbm := 0
    LOCAL cMsg := ''

    if alltrim(nIdade) != '' .and.  alltrim(nPeso) != '' .and. alltrim(cSex) != '' .and. alltrim(nAltura) != ''
        if upper(cSex) == "F"
            nTbm = 655.1 + (9.563 * Val(nPeso)) + (1.850 * Val(nAltura)) - (4.676 * Val(nIdade)) 
            cMsg := "o TMC é de: " + alltrim(str(nTbm))  

        Elseif upper(cSex) == 'M'
            nTbm = 66.5 + (13.75 * Val(nPeso)) + (5.003 * Val(nAltura)) - (6.75 * Val(nIdade))
            cMsg := "o TMC é de: " + Alltrim(STR(nTbm))  
        else 
            FwAlertError("Sexo informado incorretamente, Favor tentar novamente ")    
            RETURN
        ENDIF
        else 
            FwAlertError("Campos em branco, Favor tentar novamente ") 
            RETURN
    ENDIF
    FwAlertSucess(cMsg)


RETURN
