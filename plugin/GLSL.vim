
"====[ GLSL shaders ]=======================================================
"
command SetGLSLFileType call SetGLSLFileType()
function SetGLSLFileType()
  for item in getline(1,10)
    if item =~ "#version 330"
      execute ':set filetype=glsl330'
      break
    endif
    if item =~ "#version 400"
      execute ':set filetype=glsl400'
      break
    endif
    if item =~ "#version 410"
      execute ':set filetype=glsl410'
      break
    endif
    if item =~ "#version 420"
      execute ':set filetype=glsl420'
      break
    endif
    if item =~ "#version 430"
      execute ':set filetype=glsl430'
      break
    endif
  endfor
endfunction
