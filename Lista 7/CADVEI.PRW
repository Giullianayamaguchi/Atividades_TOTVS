#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

    /*/{Protheus.doc} User Function CADVEI
    Cadastro de veículo
    @type  Function
    @author user
    @since 27/03/2023
    /*/

User Function CADVEI()
    Local cAlias  := 'ZZV'
    Local cTitle  := "Cadastro de Veículo"
    Local oBrowse := FwMBrowse():New()   

    oBrowse:SetAlias(cAlias) 

    oBrowse:SetDescription(cTitle)        

    oBrowse:DisableDetails()   
    oBrowse:DisableReport()
    
    oBrowse:ACTIVATE()
Return 

STATIC FUNCTION MenuDef()
    Local aRotina :={}

    ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.CADVEI' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.CADVEI' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Exluir'     ACTION 'VIEWDEF.CADVEI' OPERATION 5 ACCESS 0
Return aRotina

Static Function ModelDef()

    // Cria as estruturas a serem usadas no Modelo de Dados
    Local oModel := MPFormModel():NEW('CADVEIM')     
    Local oStruZZV := FWFormStruct(1,'ZZV')         

    // Adiciona ao modelo um componente de formulário
    oModel:AddFields('ZZVMASTER', ,oStruZZV)       

    // Adicionar a descrição do Modelo de Dados
    oModel:SetDescription('Modelo de dados de clientes')

    // Adiciona a descrição dos componentes do Modelo de Dados
    oModel:GetModel('ZZVMASTER'):SetDescription('Formulario de clientes')
    oModel:SetPrimaryKey({'ZZV_COD'})

Return oModel

Static Function ViewDef()
    
    // Cria um objeto de Modelo de dados baseado no ModelDef do fonte informado
    Local oModel := FwLoadModel('CADVEI')

    // Cria as estruturas a serem usadas na View
    Local oStruZZV := FWFormStruct(2, 'ZZV')

    // Interface de visualização construída
    Local oView  := FwFormview():New()

    oView:SetModel(oModel)

    // Adiciona no nosso View um controle do tipo formulário (antiga Enchoice)

    oView:AddField('VIEW_ZZV',oStruZZV, 'ZZVMASTER')  

         
    // Cria um "box" horizontal para receber cada elemento da view

    oView:CreateHorizontalBox('TELA', 100)
    oView:SetOwnerView('VIEW_ZZV', 'TELA')
    
Return oView
