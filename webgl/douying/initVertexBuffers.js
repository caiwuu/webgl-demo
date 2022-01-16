export default function (gl) {
  // 顶点着色器的坐标与纹理坐标的映射
  const vertices = new Float32Array([
    -0.5,
    0.5,
    0.0,
    1.0,
    -0.5,
    -0.5,
    0.0,
    0.0,
    0.5,
    0.5,
    1.0,
    1.0,
    0.5,
    -0.5,
    1.0,
    0.0,
  ])
  // 创建缓冲区对象
  let vertexBuffer = gl.createBuffer()
  // 绑定buffer到缓冲对象上
  gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer)
  // 向缓冲对象写入数据
  gl.bufferData(gl.ARRAY_BUFFER, vertices, gl.STATIC_DRAW)
  const FSIZE = Float32Array.BYTES_PER_ELEMENT
  // 将缓冲区对象分配给a_Position变量
  //   let a_Position = gl.getAttribLocation(gl.program, 'a_Position')
  let a_Position
  gl.bindAttribLocation(gl.program, a_Position, 'a_Position')
  gl.vertexAttribPointer(a_Position, 2, gl.FLOAT, false, FSIZE * 4, 0)
  // 连接a_Position变量与分配给它的缓冲区对象
  gl.enableVertexAttribArray(a_Position)
  // 将缓冲区对象分配给a_TexCoord变量
  let a_TexCoord = gl.getAttribLocation(gl.program, 'a_TexCoord')
  gl.vertexAttribPointer(a_TexCoord, 2, gl.FLOAT, false, FSIZE * 4, FSIZE * 2)
  // 使用缓冲数据建立程序代码到着色器代码的联系
  gl.enableVertexAttribArray(a_TexCoord)
}
