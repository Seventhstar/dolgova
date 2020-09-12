#letters = Array.from(document.querySelectorAll('.ripple'))
#letters.forEach (letter) ->
#  timerId = undefined
#  letter.addEventListener 'mousedown', (e) ->
#    console.log(e)
#    clearTimeout timerId
#    ripple = e.target.querySelector('.ripple')
#    size = letter.offsetWidth
#    pos = letter.getBoundingClientRect()
#    x = e.pageX - (pos.left) - size
#    y = e.pageY - (pos.top) - size
#    ripple.style = 'top:' + y + 'px; left:' + x + 'px; width: ' + size * 2 + 'px; height: ' + size * 2 + 'px;'
#    ripple.classList.remove 'active'
#    ripple.classList.remove 'start'
#    setTimeout ->
#      ripple.classList.add 'start'
#      setTimeout ->
#        ripple.classList.add 'active'
#        return
#      return
#    return
#  letter.addEventListener 'mouseup', (e) ->
#    ripple = e.target.querySelector('.ripple')
#    clearTimeout timerId
#    timerId = setTimeout((->
#      ripple.classList.remove 'active'
#      ripple.classList.remove 'start'
#      return
#    ), 500)
#    return
#  return
#window.onload = ->
#  rippleElements = document.getElementsByClassName('ripple')
#  i = 0
#  while i < rippleElements.length
#
#    rippleElements[i].onclick = (e) ->
#      console.log('ripple added')
#      X = e.pageX - (@offsetLeft)
#      Y = e.pageY - (@offsetTop)
#      rippleDiv = document.createElement('div')
#      rippleDiv.classList.add 'v-ripple'
#      rippleDiv.setAttribute 'style', 'top:' + Y + 'px; left:' + X + 'px;'
#
#      customColor = @getAttribute('ripple-color')
#      if customColor
#        rippleDiv.style.background = customColor
#      @appendChild rippleDiv
#      setTimeout (->
##        rippleDiv.parentElement.removeChild rippleDiv
#        return
#      ), 20900
#      return
#
#    i++
#  return
