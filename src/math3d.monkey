Strict

Class Vec3 Final
Public
	Field X:Float
	Field Y:Float
	Field Z:Float
	
	Function Create:Vec3(x:Float = 0, y:Float = 0, z:Float = 0)
		Local v:Vec3 = New Vec3
		v.Set(x, y, z)
		Return v
	End
	
	Function Create:Vec3(other:Vec3)
		Local v:Vec3 = New Vec3
		v.Set(other)
		Return v
	End
	
	Method Set:Void(x:Float, y:Float, z:Float)
		Self.X = x
		Self.Y = y
		Self.Z = z
	End
	
	Method Set:Void(other:Vec3)
		X = other.X
		Y = other.Y
		Z = other.Z
	End
	
	Method Sum:Void(other:Vec3)
		X += other.X
		Y += other.Y
		Z += other.Z
	End
	
	Method Sum:Void(x:Float, y:Float, z:Float)
		Self.X += x
		Self.Y += y
		Self.Z += z
	End
	
	Method Sub:Void(other:Vec3)
		X -= other.X
		Y -= other.Y
		Z -= other.Z
	End
	
	Method Sub:Void(x:Float, y:Float, z:Float)
		Self.X -= x
		Self.Y -= y
		Self.Z -= z
	End
	
	Method Mul:Void(other:Vec3)
		X *= other.X
		Y *= other.Y
		Z *= other.Z
	End
	
	Method Div:Void(other:Vec3)
		X /= other.X
		Y /= other.Y
		Z /= other.Z
	End
	
	Method Sum:Void(scalar:Float)
		X += scalar
		Y += scalar
		Z += scalar
	End
	
	Method Sub:Void(scalar:Float)
		X -= scalar
		Y -= scalar
		Z -= scalar
	End
	
	Method Mul:Void(scalar:Float)
		X *= scalar
		Y *= scalar
		Z *= scalar
	End
	
	Method Div:Void(scalar:Float)
		Mul(1/scalar)
	End
	
	Method Length:Float()
		Return Sqrt(X*X + Y*Y + Z*Z)
	End
	
	Method Normalize:Void()
		Div(Length())
	End
	
	Method Dot:Float(other:Vec3)
		Return X*other.X + Y*other.Y + Z*other.Z
	End
	
	Method Cross:Void(other:Vec3)
		Cross(other.X, other.Y, other.Z)
	End
	
	Method Cross:Void(otherx:Float, othery:Float, otherz:Float)
		Local newx:Float = Y*otherz - Z*othery
		Local newy:Float = Z*otherx - X*otherz
		Local newz:Float = X*othery - Y*otherx
		Set(newx, newy, newz)
	End
	
	Method Mix:Void(other:Vec3, t:Float)
		X += (other.X - X) * t;
		Y += (other.Y - Y) * t;
		Z += (other.Z - Z) * t;
	End
Private
	Method New()
	End
End




Class Quat Final
Public
	Field W:Float
	Field X:Float
	Field Y:Float
	Field Z:Float
	
	Function Create:Quat(w:Float = 1, x:Float = 0, y:Float = 0, z:Float = 0)
		Local q:Quat = New Quat
		q.Set(w, x, y, z)
		Return q
	End
	
	Function Create:Quat(other:Quat)
		Local q:Quat = New Quat
		q.Set(other)
		Return q
	End
	
	Method Set:Void(w:Float, x:Float, y:Float, z:Float)
		Self.W = w
		Self.X = x
		Self.Y = y
		Self.Z = z
	End
	
	Method Set:Void(other:Quat)
		W = other.W
		X = other.X
		Y = other.Y
		Z = other.Z
	End
	
	Method SetAxis:Void(angle:Float, x:Float, y:Float, z:Float)
		angle *= 0.5
		Local sinAngle:Float = Sin(angle)
		Self.W = Cos(angle)
		Self.X = x * sinAngle
		Self.Y = y * sinAngle
		Self.Z = z * sinAngle
	End
	
	Method SetEuler:Void(x:Float, y:Float, z:Float)
		Local halfx:Float = x * 0.5
		Local halfy:Float = y * 0.5
		Local halfz:Float = z * 0.5
		Local sinyaw:Float = Sin(halfy)
		Local sinpitch:Float = Sin(halfx)
		Local sinroll:Float = Sin(halfz)
		Local cosyaw:Float = Cos(halfy)
		Local cospitch:Float = Cos(halfx)
		Local cosroll:Float = Cos(halfz)

		Self.W = cospitch * cosyaw * cosroll + sinpitch * sinyaw * sinroll
		Self.X = sinpitch * cosyaw * cosroll - cospitch * sinyaw * sinroll
		Self.Y = cospitch * sinyaw * cosroll + sinpitch * cosyaw * sinroll
		Self.Z = cospitch * cosyaw * sinroll - sinpitch * sinyaw * cosroll
	End
	
	Method Sum:Void(other:Quat)
		W += other.W
		X += other.X
		Y += other.Y
		Z += other.Z
	End
	
	Method Sub:Void(other:Quat)
		W -= other.W
		X -= other.X
		Y -= other.Y
		Z -= other.Z
	End
	
	Method Mul:Void(other:Quat)
		Local qw:Float = W
		Local qx:Float = X
		Local qy:Float = Y
		Local qz:Float = Z
		W = qw*other.W - qx*other.X - qy*other.Y - qz*other.Z
		X = qw*other.X + qx*other.W + qy*other.Z - qz*other.Y
		Y = qw*other.Y + qy*other.W + qz*other.X - qx*other.Z
		Z = qw*other.Z + qz*other.W + qx*other.Y - qy*other.X
	End
	
	Method Mul:Void(w:Float, x:Float, y:Float, z:Float)
		Local qw:Float = Self.W
		Local qx:Float = Self.X
		Local qy:Float = Self.Y
		Local qz:Float = Self.Z
		Self.W = qw*w - qx*x - qy*y - qz*z
		Self.X = qw*x + qx*w + qy*z - qz*y
		Self.Y = qw*y + qy*w + qz*x - qx*z
		Self.Z = qw*z + qz*w + qx*y - qy*x
	End
	
	Method Mul:Void(vec:Vec3)
		Mul(vec.X, vec.Y, vec.Z)
	End
	
	Method Mul:Void(x:Float, y:Float, z:Float)
		t1.Set(Self)
		t2.Set(0, x, y, z)
		t3.Set(Self)
		t3.Conjugate()
		t1.Mul(t2)
		t1.Mul(t3)
		tv.Set(t1.X, t1.Y, t1.Z)
	End
	
	Method Mul:Void(scalar:Float)
		W *= scalar
		X *= scalar
		Y *= scalar
		Z *= scalar
	End
	
	Method Div:Void(scalar:Float)
		Mul(1/scalar)
	End
	
	Method Normalize:Void()
		Local mag2:Float = W*W + X*X + Y*Y + Z*Z
		If mag2 > 0.00001 And Abs(mag2 - 1.0) > 0.00001
			Div(Sqrt(mag2))
		End
	End
	
	Method Conjugate:Void()
		X = -X
		Y = -Y
		Z = -Z
	End
	
	Method Angle:Float()
		Return ACos(W) * 2.0
	End
	
	Method CalcAxis:Void()
		Local len:Float = Sqrt(X*X + Y*Y + Z*Z)
		If len = 0.0 Then len = 0.00001
		tv.Set(X, Y, Z)
		tv.Div(len)
	End
	
	Method CalcEuler:Void()
		tv.Set(	ATan2(2 * (Y*Z + W*X), W*W - X*X - Y*Y + Z*Z),
				ASin(-2 * (X*Z - W*Y)),
				ATan2(2 * (X*Y + W*Z), W*W + X*X - Y*Y - Z*Z))
	End
	
	Method Lerp:Void(other:Quat, t:Float)
		t1.Set(other)
		t1.Mul(t)
		Self.Mul(1-t)
		Self.Sum(t1)
		Self.Normalize()
	End
	
	Method Slerp:Void(other:Quat, t:Float)
		t1.Set(other)
		Local dot:Float = Self.Dot(other)
		If dot < 0
			dot = -dot
			t1.Mul(-1)
		End

		If dot < 0.95
			Local angle:Float = ACos(dot)
			t1.Mul(Sin(angle*t))
			Self.Mul(Sin(angle*(1-t)))
			Self.Sum(t1)
			Self.Div(Sin(angle))
		Else
			Self.Lerp(t1, t)
		End
	End
	
	Method Dot:Float(other:Quat)
		Return W*other.W + X*other.X + Y*other.Y + Z*other.Z
	End
	
	Function ResultVector:Vec3()
		Return tv
	End
Private
	Method New()
	End
	
	'Temp quaternions used in some operations (to avoid allocations)
	Global t1:Quat = Quat.Create()
	Global t2:Quat = Quat.Create()
	Global t3:Quat = Quat.Create()
	
	'Temp vector used in some operations (to avoid allocations)
	Global tv:Vec3 = Vec3.Create()
End




Class Mat4 Final
Public
	Field M:Float[16]
	
	Function Create:Mat4()
		Local m:Mat4 = New Mat4
		m.SetIdentity()
		Return m
	End
	
	Function Create:Mat4(other:Mat4)
		Local m:Mat4 = New Mat4
		For Local i:Int = 0 Until 16
			m.M[i] = other.M[i]
		Next
		Return m
	End
	
	Function Create:Mat4(values:Float[])
		Local m:Mat4 = New Mat4
		m.Set(values)
		Return m
	End
	
	Method Set:Void(other:Mat4)
		For Local i:Int = 0 Until 16
			M[i] = other.M[i]
		Next
	End
	
	Method Set:Void(m:Float[])
		For Local i:Int = 0 Until 16
			M[i] = m[i]
		Next
	End
	
	Method SetIdentity:Void()
		For Local i:Int = 0 Until 16
			M[i] = 0
		Next
		M[0] = 1
		M[5] = 1
		M[10] = 1
		M[15] = 1
	End
	
	Method Mul:Void(other:Mat4)
		Mul(other.M)
	End
	
	Method Mul:Void(arr:Float[])
		For Local i:Int = 0 Until 4
			Local a0:Float = M[i]
			Local a1:Float = M[i+4]
			Local a2:Float = M[i+8]
			Local a3:Float = M[i+12]
			M[i] = a0*arr[0] + a1*arr[1] + a2*arr[2] + a3*arr[3]
			M[i+4] = a0*arr[4] + a1*arr[5] + a2*arr[6] + a3*arr[7]
			M[i+8] = a0*arr[8] + a1*arr[9] + a2*arr[10] + a3*arr[11]
			M[i+12] = a0*arr[12] + a1*arr[13] + a2*arr[14] + a3*arr[15]
		Next
	End
	
	Method Mul:Float(vec:Vec3, w:Float)
		Return Mul(vec.X, vec.Y, vec.Z, w)
	End
	
	Method Mul:Float(x:Float, y:Float, z:Float, w:Float)
		t1.SetIdentity()
		t1.SetTranslation(x, y, z)
		t1.M[15] = w
		t2.Set(Self)
		t2.Mul(t1)
		tv1.Set(t2.M[12], t2.M[13], t2.M[14])
		Return t2.M[15]
	End
	
	Method RC:Float(row:Int, column:Int)
		Return M[column*4 + row]
	End
	
	Method SetRC:Void(row:Int, column:Int, value:Float)
		M[column*4 + row] = value
	End
	
	Method Translate:Void(x:Float, y:Float, z:Float)
		t1.SetIdentity()
		t1.SetTranslation(x, y, z)
		Self.Mul(t1)
	End

	Method Rotate:Void(angle:Float, x:Float, y:Float, z:Float)
		t1.SetIdentity()
		t1.SetRotation(angle, x, y, z)
		Self.Mul(t1)
	End
	
	Method Scale:Void(x:Float, y:Float, z:Float)
		t1.SetIdentity()
		t1.SetScale(x, y, z)
		Self.Mul(t1)
	End
	
	Method Transpose:Void()
		t1.Set(Self)
		For Local row:Int = 0 Until 4
			For Local column:Int = 0 Until 4
				SetRC(row, column, t1.RC(column, row))
			Next
		Next
	End
	
	Method Invert:Void()		
		t1.Set(Self)
		M[ 0] =  t1.M[5] * t1.M[10] * t1.M[15] - t1.M[5] * t1.M[11] * t1.M[14] - t1.M[9] * t1.M[6] * t1.M[15] + t1.M[9] * t1.M[7] * t1.M[14] + t1.M[13] * t1.M[6] * t1.M[11] - t1.M[13] * t1.M[7] * t1.M[10];
		M[ 4] = -t1.M[4] * t1.M[10] * t1.M[15] + t1.M[4] * t1.M[11] * t1.M[14] + t1.M[8] * t1.M[6] * t1.M[15] - t1.M[8] * t1.M[7] * t1.M[14] - t1.M[12] * t1.M[6] * t1.M[11] + t1.M[12] * t1.M[7] * t1.M[10];
		M[ 8] =  t1.M[4] * t1.M[ 9] * t1.M[15] - t1.M[4] * t1.M[11] * t1.M[13] - t1.M[8] * t1.M[5] * t1.M[15] + t1.M[8] * t1.M[7] * t1.M[13] + t1.M[12] * t1.M[5] * t1.M[11] - t1.M[12] * t1.M[7] * t1.M[ 9];
		M[12] = -t1.M[4] * t1.M[ 9] * t1.M[14] + t1.M[4] * t1.M[10] * t1.M[13] + t1.M[8] * t1.M[5] * t1.M[14] - t1.M[8] * t1.M[6] * t1.M[13] - t1.M[12] * t1.M[5] * t1.M[10] + t1.M[12] * t1.M[6] * t1.M[ 9];
		M[ 1] = -t1.M[1] * t1.M[10] * t1.M[15] + t1.M[1] * t1.M[11] * t1.M[14] + t1.M[9] * t1.M[2] * t1.M[15] - t1.M[9] * t1.M[3] * t1.M[14] - t1.M[13] * t1.M[2] * t1.M[11] + t1.M[13] * t1.M[3] * t1.M[10];
		M[ 5] =  t1.M[0] * t1.M[10] * t1.M[15] - t1.M[0] * t1.M[11] * t1.M[14] - t1.M[8] * t1.M[2] * t1.M[15] + t1.M[8] * t1.M[3] * t1.M[14] + t1.M[12] * t1.M[2] * t1.M[11] - t1.M[12] * t1.M[3] * t1.M[10];
		M[ 9] = -t1.M[0] * t1.M[ 9] * t1.M[15] + t1.M[0] * t1.M[11] * t1.M[13] + t1.M[8] * t1.M[1] * t1.M[15] - t1.M[8] * t1.M[3] * t1.M[13] - t1.M[12] * t1.M[1] * t1.M[11] + t1.M[12] * t1.M[3] * t1.M[ 9];
		M[13] =  t1.M[0] * t1.M[ 9] * t1.M[14] - t1.M[0] * t1.M[10] * t1.M[13] - t1.M[8] * t1.M[1] * t1.M[14] + t1.M[8] * t1.M[2] * t1.M[13] + t1.M[12] * t1.M[1] * t1.M[10] - t1.M[12] * t1.M[2] * t1.M[ 9];
		M[ 2] =  t1.M[1] * t1.M[ 6] * t1.M[15] - t1.M[1] * t1.M[ 7] * t1.M[14] - t1.M[5] * t1.M[2] * t1.M[15] + t1.M[5] * t1.M[3] * t1.M[14] + t1.M[13] * t1.M[2] * t1.M[ 7] - t1.M[13] * t1.M[3] * t1.M[ 6];
		M[ 6] = -t1.M[0] * t1.M[ 6] * t1.M[15] + t1.M[0] * t1.M[ 7] * t1.M[14] + t1.M[4] * t1.M[2] * t1.M[15] - t1.M[4] * t1.M[3] * t1.M[14] - t1.M[12] * t1.M[2] * t1.M[ 7] + t1.M[12] * t1.M[3] * t1.M[ 6];
		M[10] =  t1.M[0] * t1.M[ 5] * t1.M[15] - t1.M[0] * t1.M[ 7] * t1.M[13] - t1.M[4] * t1.M[1] * t1.M[15] + t1.M[4] * t1.M[3] * t1.M[13] + t1.M[12] * t1.M[1] * t1.M[ 7] - t1.M[12] * t1.M[3] * t1.M[ 5];
		M[14] = -t1.M[0] * t1.M[ 5] * t1.M[14] + t1.M[0] * t1.M[ 6] * t1.M[13] + t1.M[4] * t1.M[1] * t1.M[14] - t1.M[4] * t1.M[2] * t1.M[13] - t1.M[12] * t1.M[1] * t1.M[ 6] + t1.M[12] * t1.M[2] * t1.M[ 5];
		M[ 3] = -t1.M[1] * t1.M[ 6] * t1.M[11] + t1.M[1] * t1.M[ 7] * t1.M[10] + t1.M[5] * t1.M[2] * t1.M[11] - t1.M[5] * t1.M[3] * t1.M[10] - t1.M[ 9] * t1.M[2] * t1.M[ 7] + t1.M[ 9] * t1.M[3] * t1.M[ 6];
		M[ 7] =  t1.M[0] * t1.M[ 6] * t1.M[11] - t1.M[0] * t1.M[ 7] * t1.M[10] - t1.M[4] * t1.M[2] * t1.M[11] + t1.M[4] * t1.M[3] * t1.M[10] + t1.M[ 8] * t1.M[2] * t1.M[ 7] - t1.M[ 8] * t1.M[3] * t1.M[ 6];
		M[11] = -t1.M[0] * t1.M[ 5] * t1.M[11] + t1.M[0] * t1.M[ 7] * t1.M[ 9] + t1.M[4] * t1.M[1] * t1.M[11] - t1.M[4] * t1.M[3] * t1.M[ 9] - t1.M[ 8] * t1.M[1] * t1.M[ 7] + t1.M[ 8] * t1.M[3] * t1.M[ 5];
		M[15] =  t1.M[0] * t1.M[ 5] * t1.M[10] - t1.M[0] * t1.M[ 6] * t1.M[ 9] - t1.M[4] * t1.M[1] * t1.M[10] + t1.M[4] * t1.M[2] * t1.M[ 9] + t1.M[ 8] * t1.M[1] * t1.M[ 6] - t1.M[ 8] * t1.M[2] * t1.M[ 5];
 
		Local det:Float = t1.M[0] * M[0] + t1.M[1] * M[4] + t1.M[2] * M[8] + t1.M[3] * M[12]
		If Abs(det) <= 0.00001 Then Return

		Local invdet:Float = 1.0 / det
		For Local i:Int = 0 Until 16
			M[i] *= invdet
		Next
	End
	
	Method SetOrtho:Void(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float)
		Local a:Float = 2 / (right-left)
		Local b:Float = 2 / (top-bottom)
		Local c:Float = 2 / (far-near)
		Local tx:Float = (left+right) / (left-right)
		Local ty:Float = (top+bottom) / (bottom-top)
		Local tz:Float = (near+far) / (near-far)
		Local m:Float[] = [a,0,0,0, 0,b,0,0, 0,0,c,0, tx,ty,tz,1]
		Set(m)
	End

	Method SetOrthoRH:Void(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float)
		Local a:Float = 2 / (right-left)
		Local b:Float = 2 / (top-bottom)
		Local c:Float = 2 / (near-far)
		Local tx:Float = (left+right) / (left-right)
		Local ty:Float = (top+bottom) / (bottom-top)
		Local tz:Float = (near+far) / (near-far)
		Local m:Float[] = [a,0,0,0, 0,b,0,0, 0,0,c,0, tx,ty,tz,1]
		Set(m)
	End

	Method SetFrustum:Void(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float)
		M[0]  = 2 * near / (right - left)
		M[5]  = 2 * near / (top - bottom)
		M[8]  = (left + right) / (left - right)
		M[9]  = (bottom + top) / (bottom - top)
		M[10] = (far + near) / (far - near)
		M[11] = 1
		M[14] = (2 * near * far) / (near - far)
		M[15] = 0
	End

	Method SetFrustumRH:Void(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float)
		M[0]  = 2 * near / (right - left)
		M[5]  = 2 * near / (top - bottom)
		M[8]  = (right + left) / (right - left)
		M[9]  = (top + bottom) / (top - bottom)
		M[10] = (far + near) / (near - far)
		M[11] = -1
		M[14] = (2 * near * far) / (near - far)
		M[15] = 0
	End
	
	Method SetPerspective:Void(fovy:Float, aspect:Float, near:Float, far:Float)
		Local height:Float = near * Tan(fovy*0.5)
		Local width:Float = height * aspect
		SetFrustum(-width, width, -height, height, near, far)
	End

	Method SetPerspectiveRH:Void(fovy:Float, aspect:Float, near:Float, far:Float)
		Local height:Float = near * Tan(fovy*0.5)
		Local width:Float = height * aspect
		SetFrustumRH(-width, width, -height, height, near, far)
	End
	
	Method LookAt:Void(eyex:Float, eyey:Float, eyez:Float, centerx:Float, centery:Float, centerz:Float, upx:Float, upy:Float, upz:Float)
		'Calculate z
		tv3.Set(centerx, centery, centerz)
		tv3.Sub(eyex, eyey, eyez)
		tv3.Normalize()
		
		'Calculate x
		tv1.Set(upx, upy, upz)
		tv1.Cross(tv3)
		tv1.Normalize()
		
		'Calculate y
		tv2.Set(tv3)
		tv2.Cross(tv1)
		
		'Set matrix data
		M[0] = tv1.X; M[1] = tv2.X; M[2] = tv3.X; M[3] = 0
		M[4] = tv1.Y; M[5] = tv2.Y; M[6] = tv3.Y; M[7] = 0
		M[8] = tv1.Z; M[9] = tv2.Z; M[10] = tv3.Z; M[11] = 0
		M[12] = 0; M[13] = 0; M[14] = 0; M[15] = 1
		Translate(-eyex, -eyey, -eyez)
	End

	Method LookAtRH:Void(eyex:Float, eyey:Float, eyez:Float, centerx:Float, centery:Float, centerz:Float, upx:Float, upy:Float, upz:Float)
		'Calculate z
		tv3.Set(eyex, eyey, eyez)
		tv3.Sub(centerx, centery, centerz)
		tv3.Normalize()
		
		'Calculate x
		tv1.Set(upx, upy, upz)
		tv1.Cross(tv3)
		tv1.Normalize()
		
		'Calculate y
		tv2.Set(tv3)
		tv2.Cross(tv1)
		
		'Set matrix data
		M[0] = tv1.X; M[1] = tv2.X; M[2] = tv3.X; M[3] = 0
		M[4] = tv1.Y; M[5] = tv2.Y; M[6] = tv3.Y; M[7] = 0
		M[8] = tv1.Z; M[9] = tv2.Z; M[10] = tv3.Z; M[11] = 0
		M[12] = 0; M[13] = 0; M[14] = 0; M[15] = 1
		Translate(-eyex, -eyey, -eyez)
	End
	
	Method SetTransform:Void(x:Float, y:Float, z:Float, rw:Float, rx:Float, ry:Float, rz:Float, sx:Float, sy:Float, sz:Float)
		q1.Set(rw, rx, ry, rz)
		q1.CalcAxis()
		SetIdentity()
		Translate(x, y, z)
		Rotate(q1.Angle(), q1.ResultVector().X, q1.ResultVector().Y, q1.ResultVector().Z)
		Scale(sx, sy, sz)
	End
	
	Method SetTransform:Void(x:Float, y:Float, z:Float, rx:Float, ry:Float, rz:Float, sx:Float, sy:Float, sz:Float)
		q1.SetEuler(rx, ry, rz)
		q1.CalcAxis()
		SetIdentity()
		Translate(x, y, z)
		Rotate(q1.Angle(), q1.ResultVector().X, q1.ResultVector().Y, q1.ResultVector().Z)
		Scale(sx, sy, sz)
	End
	
	Method SetBillboardTransform:Void(view:Mat4, x:Float, y:Float, z:Float, spin:Float, width:Float, height:Float, cylindrical:Bool = False)
		M[0] = view.M[0]
		M[1] = view.M[4]
		M[2] = view.M[8]
		M[3] = 0
		If cylindrical
			M[4] = 0
			M[5] = 1
			M[6] = 0
		Else
			M[4] = view.M[1]
			M[5] = view.M[5]
			M[6] = view.M[9]
		End
		M[7] = 0
		M[8] = view.M[2]
		M[9] = view.M[6]
		M[10] = view.M[10]
		M[11] = 0
		M[12] = x
		M[13] = y
		M[14] = z
		M[15] = 1

		Rotate(spin, 0, 0, 1)
		Scale(width, height, 1)
	End
	
	Function ResultVector:Vec3()
		Return tv1
	End
Private
	Method New()
	End
	
	Method SetTranslation:Void(x:Float, y:Float, z:Float)
		M[12] = x
		M[13] = y
		M[14] = z
	End

	Method SetRotation:Void(angle:Float, x:Float, y:Float, z:Float)
		Local c:Float = Cos(angle)
		Local s:Float = Sin(angle)
		Local xx:Float = x * x
		Local xy:Float = x * y
		Local xz:Float = x * z
		Local yy:Float = y * y
		Local yz:Float = y * z
		Local zz:Float = z * z

		M[0] = xx * (1 - c) + c
		M[1] = xy * (1 - c) + z * s
		M[2] = xz * (1 - c) - y * s
		M[4] = xy * (1 - c) - z * s
		M[5] = yy * (1 - c) + c
		M[6] = yz * (1 - c) + x * s
		M[8] = xz * (1 - c) + y * s
		M[9] = yz * (1 - c) - x * s
		M[10] = zz * (1 - c) + c
	End
	
	Method SetScale:Void(x:Float, y:Float, z:Float)
		M[0] = x
		M[5] = y
		M[10] = z
	End
	
	'Temp matrices used in some operations (to avoid allocations)
	Global t1:Mat4 = Mat4.Create()
	Global t2:Mat4 = Mat4.Create()
	
	'Temp quaternion used in some operations (to avoid allocations)
	Global q1:Quat = Quat.Create()
	
	'Temp vectors used in some operations (to avoid allocations)
	Global tv1:Vec3 = Vec3.Create()
	Global tv2:Vec3 = Vec3.Create()
	Global tv3:Vec3 = Vec3.Create()
End

