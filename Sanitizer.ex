defmodule Sanitizer do
  def sanitize_source(file_content) do
   	trimmed_content = String.trim(file_content)
     	words =Regex.split(~r/\n/,trimmed_content)
     	contador=0
   	doList(words,contador)
  end
  def doList(program,linea) when program != []  do
      codLine=hd program
      otherL=tl program
      tknListNoNum = Regex.split(~r/\s+/,codLine, trim: true)
      tknListNum=Enum.flat_map(tknListNoNum, fn x -> [{x,linea}] end)
      linea=linea+1
      otrostokens=doList(otherL,linea)
      tknListNum ++ otrostokens
  end

  def doList(_program,_linea)  do
      []
  end
end