#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

    /*/{Protheus.doc} User Function CADCAT
    Cadastro de alunos 
    @type  Function
    @author user
    @since 27/03/2023
    /*/

User Function CADCAT()
    Local cAlias  := 'ZZD'
    Local cTitle  := "Categoria de CNH"
    Local oBrowse := FwMBrowse():New()   

    oBrowse:SetAlias(cAlias) 

    oBrowse:SetDescription(cTitle)        

    oBrowse:DisableDetails()   
    oBrowse:DisableReport()
    
    oBrowse:ACTIVATE()
Return 

STATIC FUNCTION MenuDef()
    Local aRotina :={}

    ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.CADCAT' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.CADCAT' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Exluir'     ACTION 'VIEWDEF.CADCAT' OPERATION 5 ACCESS 0
Return aRotina

Static Function ModelDef()

     // Cria as estruturas a serem usadas no Modelo de Dados
    Local bModelPro := {|oModel|MdlProVld(oModel) }
    Local oModel := MPFormModel():NEW('CADCATM', ,bModelPro)     
    Local oStruZZD := FWFormStruct(1,'ZZD')       
    Local aTrig    := FwStruTrigger('ZZD_CDUSA','ZZD_NOUSA','ZZV->ZZV_NOME',.T.,'ZZV',1,'xFilial("ZZV")+Alltrim(M->ZZD_CDUSA)') 
    
    oStruZZD:AddTrigger(aTrig[1],aTrig[2],aTrig[3],aTrig[4]) 

    // Adiciona ao modelo um componente de formul�rio
    oModel:AddFields('ZZDMASTER', ,oStruZZD)       
    oStruZZD:SetProperty('ZZD_COD', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, 'GetSXEnum("ZZD", "ZZD_COD")'))
    
    // Adiciona a descri��o do Modelo de Dados
    oModel:SetDescription('Cadastro de CNH')

    // Adiciona a descri��o dos Componentes do Modelo de Dados
    oModel:GetModel('ZZDMASTER'):SetDescription('Cadastro de CNH')

    oModel:SetPrimaryKey({'ZZD_COD'})

Return oModel

Static Function ViewDef()
    // Cria um objeto de Modelo de dados baseado no ModelDef do fonte informado
    Local oModel := FwLoadModel('CADCAT')

    // Cria as estruturas a serem usadas na View
    Local oStruZZD := FWFormStruct(2, 'ZZD')

    // Interface de visualiza��o constru�da
    Local oView  := FwFormview():New()

    oView:SetModel(oModel)

     // Adiciona no nosso View um controle do tipo formul�rio (antiga Enchoice)
    oView:AddField('VIEW_ZZD',oStruZZD, 'ZZDMASTER')       

    // Cria um "box" horizontal para receber cada elemento da view
    oView:CreateHorizontalBox('TELA', 100)

    // Relaciona o identificador (ID) da View com o "box" para exibi��o
    oView:SetOwnerView('VIEW_ZZD', 'TELA')
    
Return oView

Static Function MdlProVld(oModel)

    // Cria as estruturas a serem usadas na valida��o
    Local lValid := .T.
    Local nPc := oModel:GetOperation()
    Local cCont := AllTrim(oModel:GetValue('ZZDMASTER', 'ZZD_SIGLA'))

    //validar se est� na inclus�o 
    IF nPc == 3

    // valida se � diferente de 1 ou 3 letras
        IF LEN(cCont) != 1 .AND. LEN(cCont) != 3
            lValid :=  .f.
            help(,,'erro',,'Favor revisar a sigla, � necess�rio que tenha 1 ou 3 letras',1,0,,,,,)
        ENDIF

    ENDIF
Return lValid

Static Function MdlPreVld(oModel)

     // Cria as estruturas a serem usadas na valida��o
    Local lValid := .T.
    Local nOpc := oModel:GetOperation()
    Local cEsc := AllTrim(oModel:GetValue('ZZIMASTER', 'ZZI_ESCOLA'))
    Local cIda := (oModel:GetValue('ZZIMASTER', 'ZZI_NASC'))
    Local cHab := (oModel:GetValue('ZZIMASTER', 'ZZI_HABILI'))
 
    //Valida se est� na inclus�o
    IF nOpc == 3

    //valida se o instrutor tem mais de 21 anos
        IF DateDiffYear(cIda, DATE())< 21 
            lValid := .F.
            help(,,'erro',,'Favor revisar as informa��es referente a Ensino', 1, 0,,,,,,{'Necess�rio ter conclu�do ensino M�dio'})

    //valida se o instrutor tem mais de 2 anos de habilita��o
        Elseif DateDiffYear(cHab, DATE())< 2
            lValid := .F.
            help(,,'erro',,'Favor revisar as informa��es',1,0,,,,,{'Necess�rio estar habilitado h� 2 anos, no m�nimo'})
    
    //valida se o instrutor tem ensino acima de ensino fundamental
        Elseif cEsc == '1-Ensino Fundamental'
            lValid := .F.
            help(,,'erro',,'Favor revisar as informa��es',1,0,,,,,{'Necess�rio ter atingido a maioridade (21 anos)'})

        ENDIF
    ENDIF
Return lValid
