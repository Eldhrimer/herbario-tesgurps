# encoding: UTF-8
require 'tk'
require 'tkextlib/tile'
require_relative 'herbario_Logic'

$lista_de_ingredientes = Ingrediente.new
#__________Debug________________/
#p ing_nombres

#______Ventana Principal_____________/
root = TkRoot.new
root.title = "Herbario"
root['geometry'] = "500x200+200+200"
content = Tk::Tile::Frame.new(root) {padding "5 5 12 0"}.grid :column => 0, :row => 0, :sticky => "nwes"
TkGrid.columnconfigure root, 0, :weight => 1
TkGrid.rowconfigure root, 0, :weight => 1
TkGrid.columnconfigure content, 0, :weight => 1
TkGrid.rowconfigure content, 5, :weight => 1


#_____________________Panel de nombres___________________/
$ing_nombres = $lista_de_ingredientes.get_nombre
$ing_nombres_show = TkVariable.new($ing_nombres)

$panel_de_nombres = TkListbox.new(content) do
  listvariable $ing_nombres_show
  grid :column => 0, :row => 0, :rowspan => 6, :sticky => 'nswe'
  selectmode "browse"
end

scroll = Tk::Tile::Scrollbar.new(content) do
    orient 'vertical'
    grid(:column => 1, :row => 0, :rowspan => 6, :sticky => 'nsew')
end

$panel_de_nombres.yscrollcommand(proc { |*args|
  scroll.set(*args)
})

scroll.command(proc { |*args|
  $panel_de_nombres.yview(*args)
}) 
0.step($ing_nombres.length-1, 2) {|i| $panel_de_nombres.itemconfigure i, :background, "#f0f0ff"}
s1 = Tk::Tile::Separator.new(content) do
   orient 'vertical'
   grid  :column => 2, :row => 0, :rowspan => 6, :sticky => 'ns'
end

#____________________Visualisador de detalles____________________/

$detalles_detalles = TkVariable.new("")
$detalles_efectos1 = TkVariable.new("")
$detalles_efectos2 = TkVariable.new("")
label_detalles = Tk::Tile::Label.new(content) {
  textvariable $detalles_detalles; anchor "center"
  grid  :column => 3, :row => 1, :columnspan => 6, :sticky => 'we'
}
$panel_de_nombres.bind '<ListboxSelect>', proc {
  show_detalles
}

label_efectos = Tk::Tile::Label.new(content) {
  text "Efectos"; anchor "center"
  grid  :column => 3, :row => 2, :columnspan => 6, :sticky => 'we'
}
cuadro_efectos = Tk::Tile::Frame.new(content) {
  grid :column => 3, :row => 3, :columnspan => 6, :sticky => 'nswe'
}
TkGrid.columnconfigure cuadro_efectos, 0, :weight => 1
TkGrid.rowconfigure cuadro_efectos, 5, :weight => 1

      label_efectos1 = Tk::Tile::Label.new(cuadro_efectos) {
        textvariable $detalles_efectos1; anchor "center"
        grid  :column => 1, :row => 0, :rowspan => 6, :sticky => 'we'
      }
      s2 = Tk::Tile::Separator.new(cuadro_efectos) do
         orient 'vertical'
         grid  :column => 2, :row => 0, :rowspan => 6, :sticky => 'ns'
      end
      label_efectos2 = Tk::Tile::Label.new(cuadro_efectos) {
        textvariable $detalles_efectos2; anchor "center"
        grid  :column => 3, :row => 0, :rowspan => 6, :sticky => 'we'
      }

def show_detalles
  index_get = $panel_de_nombres.curselection
#  p $panel_de_nombres.curselection
  index_sent = index_get[0].to_i
  detalles = $lista_de_ingredientes.get_detalles(index_sent)
#  p detalles
 $detalles_detalles.value = "#{detalles[0].capitalize}\
  \nValor: #{detalles[1]} dw, #{detalles[2]} dr, #{detalles[3]} dv, #{detalles[4]} pq\nPeso: #{detalles[5]} lbs" 
 $detalles_efectos1.value = "#{detalles[6]}\n#{detalles[7]}"
 $detalles_efectos2.value = "#{detalles[8]}\n#{detalles[9]}"
end

$panel_de_nombres.selection_set 0
show_detalles



#________________________________Nuevo ingrediente_______________________________________________________________/
Tk::Tile::Button.new(content) do
  text "Nuevo"
  grid :column => 6, :row => 7, :sticky => 'e'
  command "crear_ventana"
end

def crear_ventana
  $var_nombre = TkVariable.new("")
  $var_valordw = TkVariable.new("")
  $var_valordr = TkVariable.new("")
  $var_valordv = TkVariable.new("")
  $var_valorpq = TkVariable.new("")
  $var_peso = TkVariable.new("")
  $var_efecto1 = TkVariable.new("")
  $var_efecto2 = TkVariable.new("")
  $var_efecto3 = TkVariable.new("") 
  $var_efecto4 = TkVariable.new("")  
  $var_valordw.value = 0
  $var_valordr.value = 0
  $var_valordv.value = 0
  $var_valorpq.value = 0
  $var_peso.value = 0
  $var_efecto1.value = "Desconocido"
  $var_efecto2.value = "Desconocido"
  $var_efecto3.value = "Desconocido" 
  $var_efecto4.value = "Desconocido"
  $forma = TkToplevel.new
  $forma.title = "Añadir ingrediente"
  $forma['geometry'] = "240x220+400+200"
  newcontent = Tk::Tile::Frame.new($forma) {padding "5 5 5 5"}.grid :column => 0, :row => 0, :sticky => "nwes"
  TkGrid.columnconfigure $forma, 0, :weight => 1
  TkGrid.rowconfigure $forma, 0, :weight => 1
  TkGrid.columnconfigure newcontent, 0, :weight => 1
  TkGrid.columnconfigure newcontent, 1, :weight => 1
  TkGrid.columnconfigure newcontent, 2, :weight => 1
  TkGrid.columnconfigure newcontent, 3, :weight => 1

      label_nombre = Tk::Tile::Label.new(newcontent) {
        text "Nombre"; anchor "center"
        grid  :column => 0, :row => 0, :columnspan => 6, :sticky => 'we'
      }
      field_nombre = Tk::Tile::Entry.new(newcontent){
        textvariable $var_nombre
        grid  :column => 0, :row => 1, :columnspan => 6, :sticky => 'we'
      }
      label_valor = Tk::Tile::Label.new(newcontent) {
        text "Valor (dw, dr, dv, pq)"; anchor "center"
        grid  :column => 0, :row => 2, :columnspan => 6, :sticky => 'we'
      }
      field_valordw = Tk::Tile::Entry.new(newcontent){
        textvariable $var_valordw
        grid  :column => 0, :row => 3, :columnspan => 1, :sticky => 'we'
      }
      field_valordr = Tk::Tile::Entry.new(newcontent){
        textvariable $var_valordr
        grid  :column => 1, :row => 3, :columnspan => 1, :sticky => 'we'
      }
      field_valordv = Tk::Tile::Entry.new(newcontent){
        textvariable $var_valordv
        grid  :column => 2, :row => 3, :columnspan => 1, :sticky => 'we'
      }
      field_valorpq = Tk::Tile::Entry.new(newcontent){
        textvariable $var_valorpq
        grid  :column => 3, :row => 3, :columnspan => 1, :sticky => 'we'
      }
      label_peso = Tk::Tile::Label.new(newcontent) {
        text "Peso en libras"; anchor "center"
        grid  :column => 0, :row => 4, :columnspan => 6, :sticky => 'we'
      }
      field_peso = Tk::Tile::Entry.new(newcontent){
        textvariable $var_peso
        grid  :column => 0, :row => 5, :columnspan => 6, :sticky => 'we'
      }
      label_efectos = Tk::Tile::Label.new(newcontent) {
        text "Efectos"; anchor "center"
        grid  :column => 0, :row => 6, :columnspan => 4, :sticky => 'we'
      }
      field_efecto1 = Tk::Tile::Entry.new(newcontent){
        textvariable $var_efecto1
        grid  :column => 0, :row => 7, :columnspan => 2, :sticky => 'we'
      }
      field_efecto2 = Tk::Tile::Entry.new(newcontent){
        textvariable $var_efecto2
        grid  :column => 0, :row => 8, :columnspan => 2, :sticky => 'we'
      }
      field_efecto3 = Tk::Tile::Entry.new(newcontent){
        textvariable $var_efecto3
        grid  :column => 2, :row => 7, :columnspan => 2, :sticky => 'we'
      }
      field_efecto4 = Tk::Tile::Entry.new(newcontent){
        textvariable $var_efecto4
        grid  :column => 2, :row => 8, :columnspan => 2, :sticky => 'we'
      }
      $añadir = Tk::Tile::Button.new(newcontent) {
        text "Añadir"
        grid :column => 2, :row => 9, :sticky => 'w'
        command "nuevo_ingrediente"
      }
      $cancelar = Tk::Tile::Button.new(newcontent) {
        text "Cancelar"
        grid :column => 1, :row => 9, :sticky => 'e'
        command proc {$forma.destroy}
      }
      $forma.bind("Return") {
        nuevo_ingrediente
      }
end
def nuevo_ingrediente
  $lista_de_ingredientes.añadir_ingrediente($var_nombre.to_s, $var_valordw.to_i, $var_valordr.to_i, $var_valordv.to_i, $var_valorpq.to_i, $var_peso.to_f, $var_efecto1.to_s, $var_efecto2.to_s, $var_efecto3.to_s, $var_efecto4.to_s)
  $ing_nombres = $lista_de_ingredientes.get_nombre
  $ing_nombres_show.value = $ing_nombres
  $forma.destroy
end
#_____________________________Eliminar ingrediente________________________/
Tk::Tile::Button.new(content) do
  text "Eliminar"
  grid :column => 5, :row => 7, :sticky => 'e'
  command "borrar_ingrediente"
end
root.bind("Delete") {
  borrar_ingrediente
}
def borrar_ingrediente
  $confimacion = Tk::messageBox(
  'type'    => "yesno",  
  'icon'    => "warning", 
  'title'   => "Confirmar eliminación",
  'message' => "Está a punto de borrar un ingrediente.\n¿Confirmar acción?"
)
  if $confimacion == "yes"
    index_get = $panel_de_nombres.curselection
    index_sent = index_get[0].to_i
    eliminado = $lista_de_ingredientes.get_for_delete(index_sent)
    $ing_nombres = $lista_de_ingredientes.get_nombre
    $ing_nombres_show.value = $ing_nombres
    $panel_de_nombres.selection_set 0
    show_detalles
  end
end
#___________________Editar ingrediente__________________________________________________________________________/
Tk::Tile::Button.new(content) do
  text "Editar"
  grid :column => 0, :row => 7, :sticky => 'w'
  command "editar_ventana"
end

def editar_ventana
  index_get = $panel_de_nombres.curselection
  index_sent = index_get[0].to_i
  detalles = $lista_de_ingredientes.get_detalles(index_sent)
  $var_ed_nombre = TkVariable.new(detalles[0])
  $var_ed_valordw = TkVariable.new(detalles[1])
  $var_ed_valordr = TkVariable.new(detalles[2])
  $var_ed_valordv = TkVariable.new(detalles[3])
  $var_ed_valorpq = TkVariable.new(detalles[4])
  $var_ed_peso = TkVariable.new(detalles[5])
  $var_ed_efecto1 = TkVariable.new(detalles[6])
  $var_ed_efecto2 = TkVariable.new(detalles[7])
  $var_ed_efecto3 = TkVariable.new(detalles[8]) 
  $var_ed_efecto4 = TkVariable.new(detalles[9])
  $forma_edit = TkToplevel.new
  $forma_edit.title = "Editar ingrediente"
  $forma_edit['geometry'] = "240x220+400+200"
  editcontent = Tk::Tile::Frame.new($forma_edit) {padding "5 5 5 5"}.grid :column => 0, :row => 0, :sticky => "nwes"
  TkGrid.columnconfigure $forma_edit, 0, :weight => 1
  TkGrid.rowconfigure $forma_edit, 0, :weight => 1
  TkGrid.columnconfigure editcontent, 0, :weight => 1
  TkGrid.columnconfigure editcontent, 1, :weight => 1
  TkGrid.columnconfigure editcontent, 2, :weight => 1
  TkGrid.columnconfigure editcontent, 3, :weight => 1

      label_nombre = Tk::Tile::Label.new(editcontent) {
        text "Nombre"; anchor "center"
        grid  :column => 0, :row => 0, :columnspan => 6, :sticky => 'we'
      }
      field_nombre = Tk::Tile::Entry.new(editcontent){
        textvariable $var_ed_nombre
        grid  :column => 0, :row => 1, :columnspan => 6, :sticky => 'we'
      }
      label_valor = Tk::Tile::Label.new(editcontent) {
        text "Valor (dw, dr, dv, pq)"; anchor "center"
        grid  :column => 0, :row => 2, :columnspan => 5, :sticky => 'we'
      }
      field_valordw = Tk::Tile::Entry.new(editcontent){
        textvariable $var_ed_valordw
        grid  :column => 0, :row => 3, :columnspan => 1, :sticky => 'we'
      }
      field_valordr = Tk::Tile::Entry.new(editcontent){
        textvariable $var_ed_valordr
        grid  :column => 1, :row => 3, :columnspan => 1, :sticky => 'we'
      }
      field_valordv = Tk::Tile::Entry.new(editcontent){
        textvariable $var_ed_valordv
        grid  :column => 2, :row => 3, :columnspan => 1, :sticky => 'we'
      }
      field_valorpq = Tk::Tile::Entry.new(editcontent){
        textvariable $var_ed_valorpq
        grid  :column => 3, :row => 3, :columnspan => 1, :sticky => 'we'
      }
      label_peso = Tk::Tile::Label.new(editcontent) {
        text "Peso en libras"; anchor "center"
        grid  :column => 0, :row => 4, :columnspan => 6, :sticky => 'we'
      }
      field_peso = Tk::Tile::Entry.new(editcontent){
        textvariable $var_ed_peso
        grid  :column => 0, :row => 5, :columnspan => 6, :sticky => 'we'
      }
      label_efectos = Tk::Tile::Label.new(editcontent) {
        text "Efectos"; anchor "center"
        grid  :column => 0, :row => 6, :columnspan => 4, :sticky => 'we'
      }
      field_efecto1 = Tk::Tile::Entry.new(editcontent){
        textvariable $var_ed_efecto1
        grid  :column => 0, :row => 7, :columnspan => 2, :sticky => 'we'
      }
      field_efecto2 = Tk::Tile::Entry.new(editcontent){
        textvariable $var_ed_efecto2
        grid  :column => 0, :row => 8, :columnspan => 2, :sticky => 'we'
      }
      field_efecto3 = Tk::Tile::Entry.new(editcontent){
        textvariable $var_ed_efecto3
        grid  :column => 2, :row => 7, :columnspan => 2, :sticky => 'we'
      }
      field_efecto4 = Tk::Tile::Entry.new(editcontent){
        textvariable $var_ed_efecto4
        grid  :column => 2, :row => 8, :columnspan => 2, :sticky => 'we'
      }
      $editar = Tk::Tile::Button.new(editcontent) {
        text "Editar"
        grid :column => 2, :row => 9, :sticky => 'w'
        command "editar_ingrediente"
      }
      $cancelar = Tk::Tile::Button.new(editcontent) {
        text "Cancelar"
        grid :column => 1, :row => 9, :sticky => 'e'
        command proc {$forma_edit.destroy}
      }
      $forma_edit.bind("Return") {
        editar_ingrediente
      }
end
def editar_ingrediente
  $lista_de_ingredientes.editar_ingrediente($var_ed_nombre.to_s, $var_ed_valordw.to_i, $var_ed_valordr.to_i, $var_ed_valordv.to_i, $var_ed_valorpq.to_i, $var_ed_peso.to_f, $var_ed_efecto1.to_s, $var_ed_efecto2.to_s, $var_ed_efecto3.to_s, $var_ed_efecto4.to_s)
  $ing_nombres = $lista_de_ingredientes.get_nombre
  $ing_nombres_show.value = $ing_nombres
  $forma_edit.destroy
end



Tk.mainloop