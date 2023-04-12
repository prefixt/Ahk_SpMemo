class History {
    static ReadHistory(lv) {
        ; 读取文本并写入到指定listview控件
        f := FileOpen('ctrl/history.txt', 'r')
        validPath := ''
        total := 0
        while (path := f.ReadLine()) != '' {
            filename := SubStr(path, InStr(path, '\', , -1) + 1)
            ori := path
            path := StrReplace(path, 'A_Desktop', A_Desktop)
            if not this.CheckValidity(path) ; invalid
                continue
            validPath .= ori '`n'
            lv.Add(, filename, path)
            total++
        }
        f.Close()
        this.WriteHistory(validPath, 'w')
        return total
    }

    static CheckValidity(path) {
        ; Test whether the file exists
        if not FileExist(path)
            return false ; invalid
        return true
    }

    static WriteHistory(path, mode) {
        ; 将文件路径写入到文history.txt
        f := FileOpen('ctrl/history.txt', mode)
        f.Write(path)
        f.Close()
    }

    static CheckCfgFile() {
        f := FileOpen('ctrl/history.txt', 'r')
        if f.Read() = ''
            return false
        return true
    }
}