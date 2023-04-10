#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

    /*/{Protheus.doc} User Function CatVis
    Categoria VisualizaÃ§Ã£o
    @type  Function
    @author Giulliana Yamaguchi
    @since 28/03/2023
    /*/

User Function CatVis()

    Local oBrowse := FwMBrowse():New()   

    oBrowse:SetAlias('ZZD') 

    oBrowse:SetDescription('Consultar')        

    oBrowse:DisableDETAILSs()   
    oBrowse:DisableReport()
    
    oBrowse:ACTIVATE()
Return 

STATIC FUNCTION MenuDef()
    Local aRotina :={}

    ADD OPTION aRotina TITLE 'Visualizar'    ACTION 'VIEWDEF.CatVis' OPERATION 2 ACCESS 0
    
Return aRotina

Static Function ModelDef()

    // Cria as estruturas a serem usadas no Modelo de Dados
    Local oModel       := MPFormModel():New('CatVisM')
    Local oStruZZD     := FWFormStruct(1, 'ZZD')
    Local oStruZZI     := FWFormStruct(1, 'ZZI')
    Local oStruZZA     := FWFormStruct(1, 'ZZA')
    
    // Adiciona ao modelo um componente de formulário
    oModel:AddFields('ZZDMASTER',, oStruZZD)
    oModel:AddGrid('ZZIDETAILS', 'ZZDMASTER', oStruZZI)
    oModel:AddGrid('ZZADETAILS', 'ZZIDETAILS', oStruZZA)

    // Adiciona a descrição do Modelo de Dados
    oModel:SetDescription('Consulta - Visualizar')

    // Faz relacionamento entre os componentes do model
    oModel:SetRelation('ZZIDETAILS', {{'ZZI_FILIAL', 'xFilial("ZZI")'},{'ZZI_CAD', 'ZZD_COD'}}, ZZI->(IndexKey(1)))
    oModel:SetRelation('ZZADETAILS', {{'ZZA_FILIAL', 'xFilial("ZZA")'},{'ZZA_CDINST', 'ZZI_COD'}}, ZZA->(IndexKey(1)))

    // Adiciona a descrição dos Componentes do Modelo de Dados
    oModel:GetModel('ZZDMASTER'):SetDescription('Categoria de CNH')
    oModel:GetModel('ZZIDETAILS'):SetDescription('Instrutor')
    oModel:GetModel('ZZADETAILS'):SetDescription('Aluno')

    oModel:SetPrimaryKey({'ZZD_COD', 'ZZI_COD', 'ZZA_COD'})

Return oModel

Static Function ViewDef()
    // Cria um objeto de Modelo de dados baseado no ModelDef do fonte informado
    Local oModel       := FwLoadModel('CatVis')

    // Cria as estruturas a serem usadas na View
    Local oStruZZD     := FWFormStruct(2, 'ZZD')
    Local oStruZZI     := FWFormStruct(2, 'ZZI')
    Local oStruZZA     := FWFormStruct(2, 'ZZA')

    // Interface de visualização construída
    Local oView        := FwFormview():New()

    oView:SetModel(oModel)

    // Adiciona no nosso View um controle do tipo formulário (antiga Enchoice)

    oView:AddField('VIEW_ZZD',oStruZZD, 'ZZDMASTER')     
    oView:AddGrid('VIEW_ZZI',oStruZZI, 'ZZIDETAILS')
    oView:AddGrid('VIEW_ZZA',oStruZZA, 'ZZADETAILS')

    // Cria um "box" horizontal para receber cada elemento da view

    oView:CreateHorizontalBox('CNH', 40)
    oView:CreateHorizontalBox('Instrutor', 20)
    oView:CreateHorizontalBox('Alunos', 40)
    
    // Relaciona o identificador (ID) da View com o "box" para exibição

    oView:SetOwnerView('VIEW_ZZD', 'CNH') 
    oView:SetOwnerView('VIEW_ZZI', 'Instrutor')   
    oView:SetOwnerView('VIEW_ZZA', 'Alunos') 

Return oView
