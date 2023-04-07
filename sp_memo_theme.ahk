class SpMemoTheme {
    ; can't set:
    ; - statusBar : font color, border
    ; - edit : border, scroolBar
    ; - button : all
    ; - listView : grid, selectedItemBgc, titleFontColor
    static DEFAULT_COLOR := 'default'
    window_Bgc := SpMemoTheme.DEFAULT_COLOR
    title_Fc := SpMemoTheme.DEFAULT_COLOR
    headerBar_Bgc := SpMemoTheme.DEFAULT_COLOR
    fileNameText_Fc := SpMemoTheme.DEFAULT_COLOR
    hanatEmoText_Fc := SpMemoTheme.DEFAULT_COLOR
    editA_Bgc := SpMemoTheme.DEFAULT_COLOR
    editA_Fc := SpMemoTheme.DEFAULT_COLOR
    editB_Bgc := SpMemoTheme.DEFAULT_COLOR
    editB_Fc := SpMemoTheme.DEFAULT_COLOR
    editC_Bgc := SpMemoTheme.DEFAULT_COLOR
    editC_Fc := SpMemoTheme.DEFAULT_COLOR
    lv_Fc := SpMemoTheme.DEFAULT_COLOR
    lv_Bgc := SpMemoTheme.DEFAULT_COLOR
    statusBar_Bgc := SpMemoTheme.DEFAULT_COLOR
}

class Dark extends SpMemoTheme {
    __New() {
        this.default_Fc := 'DCDFE4'
        this.window_Bgc := '282C34'
        this.title_Fc := 'DCDFE4'
        this.headerBar_Bgc := '5B6475'
        this.fileNameText_Fc := '61AFEF'
        this.hanatEmoText_Fc := 'E06C75'
        this.editA_Bgc := '393B30'
        this.editA_Fc := '61CEDB'
        this.editB_Bgc := '303B39'
        this.editB_Fc := 'E5A36E'
        this.editC_Bgc := '303B39'
        this.editC_Fc := '61CEDB'
        this.lv_Fc := 'B9CAE4'
        this.lv_Bgc := '434957'
        this.statusBar_Bgc := '94A3BF'
    }
}

class Light extends SpMemoTheme {
    __New() {
        this.default_Fc := '682d00'
        this.window_Bgc := 'f6eeda'
        this.title_Fc := '682d00'
        this.headerBar_Bgc := 'FFFEF0'
        this.fileNameText_Fc := '682d00'
        this.hanatEmoText_Fc := '682d00'
        this.editA_Bgc := 'fffaed'
        this.editA_Fc := '165146'
        this.editB_Bgc := 'fffaf4'
        this.editB_Fc := '553215'
        this.editC_Bgc := 'fffaf4'
        this.editC_Fc := '165146'
        this.lv_Fc := '00667d'
        this.lv_Bgc := 'fffaed'
        this.statusBar_Bgc := 'e8e1cd'
    }
}