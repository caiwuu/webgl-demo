#ifdef GL_ES
    precision mediump float;
    #endif
    uniform sampler2D u_Sampler;
    uniform float offset;
    uniform float speed;
    uniform float time;
    varying vec2 v_TexCoord;
    float random (vec2 st) {
        return fract(sin(dot(st.xy, vec2(12.9898,78.233)))* 43758.5453123);
    }
    float randomRange (vec2 standard ,float min, float max) {
        return min + random(standard) * (max - min);
    }
    void main () {
      // 原图
        vec4 color = texture2D(u_Sampler, v_TexCoord).rgba;
      // 位移值放缩 0.0-0.5
      float maxOffset = offset / 6.0;
      // 时间计算
      float cTime = floor(time * speed * 50.0);
      // 切割图片的最大位移值
      float maxSplitOffset = offset / 6.0;
      // 这里我们选择切割10次
      for (float i = 0.0; i < 10.0; i += 1.0) {
            // 切割纵向坐标
            float sliceY = random(vec2(cTime + offset, 1999.0 + float(i)));
            // 切割高度
            float sliceH = random(vec2(cTime + offset, 9999.0 + float(i))) * 0.25;
            // 计算随机横向偏移值
            float hOffset = randomRange(vec2(cTime + offset, 9625.0 + float(i)), -maxSplitOffset, maxSplitOffset);
            // 计算最终坐标
            vec2 splitOff = v_TexCoord; splitOff.x += hOffset; splitOff = fract(splitOff);
            // 片段如果在切割区间，就偏移区内图像
            if (v_TexCoord.y > sliceY && v_TexCoord.y < fract(sliceY+sliceH)) {
            color = texture2D(u_Sampler, splitOff).rgba;
            }
      }
      vec2 texOffset = vec2(randomRange(vec2(cTime + maxOffset, 9999.0), -maxOffset, maxOffset), randomRange(vec2(cTime, 9999.0), -maxOffset, maxOffset));
      vec2 uvOff = fract(v_TexCoord + texOffset);
      // rgb随机分离
      float rnd = random(vec2(cTime, 9999.0));
      if (rnd < 0.33){
        color.r = texture2D(u_Sampler, uvOff).r;
      }else if (rnd < 0.66){
        color.g = texture2D(u_Sampler, uvOff).g;
      } else{
        color.b = texture2D(u_Sampler, uvOff).b;
      }
      gl_FragColor = vec4(color.r,color.g,color.b, 1.0);
      //gl_FragColor = vec4(1.0,0.0,0.0,1.0);
    }