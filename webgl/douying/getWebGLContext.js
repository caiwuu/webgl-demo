export default function (canvas) {
  let gl
  let glContextNames = ['webgl', 'experimental-webgl']
  for (let i = 0; i < glContextNames.length; i++) {
    try {
      gl = canvas.getContext(glContextNames[i], {})
    } catch (e) {}
  }
  if (gl) {
    gl.clearColor(0, 0, 0, 0)
    gl.clear(gl.COLOR_BUFFER_BIT)
  }
  return gl
}
