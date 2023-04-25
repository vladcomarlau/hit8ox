--hit8ox
--vlad-constantin comarlau
--april 2023
function _init()
 init_data()
 poke(0x5f2e,1)
end
function _update()
	key=stat(31)
	g_time=time()
end
function _draw()
	camera()
	ai()
	gameplay()
	local d={}
	for i=1,2 do
	 d[i]=dist3
	(
		ppos[i][1],
		ppos[i][2],
		ppos[i][3],
		cam_p[1],
		cam_p[2],
		cam_p[3]
		)
	end
	draw_menu()
	draw_env()
	if game_state!="selector"
	then
		if d[1]>d[2] then
			draw_fighter(1)
			draw_fighter(2)
		else
			draw_fighter(2)
			draw_fighter(1)
		end
	end
	if game_state=="editor"
	then
		print("\#1\fb🅾️/z change         ❎ next",10,117)
	end
	draw_particles(true)
	update_ui()
	if game_state=="menu"
	then
 	camera(fade_time*8)
		print("\fb\#1\fb❎ play",143,117)
	end
end
-->8
--3d
function quad(
 x,y,z,
 w,l,
 rx,ry,rz,
	col)
	local ox,oy,oz,p,sp,c,s,c2,s2,c3,s3 = x,y,z	
	 ,{
	x-w, y, z-l,
	x-w, y, z+l,
	x+w, y, z+l,
	x+w, y, z-l},{},cos(ry),sin(ry),cos(rx),sin(rx),cos(rz),sin(rz)
	for i=1,4 do
		local m,e=i*3
		local e=m-2
		local xx,pf=p[e]-ox,p[m]-oz
		p[e],p[m]=c*xx-s*pf+ox,s*xx+c*pf+oz
		local g= m-1
		local xx,pf =p[g]-oy,p[m]-oz
		p[g],p[m]=	c2*xx-s2*pf+oy,s2*xx+c2*pf+oz
		local xx,ppp =p[g]-oy,p[e]-ox
		p[g],p[e]=c3*xx-s3*ppp+oy,s3*xx+c3*ppp+ox
  local r=
  64/max((p[m]-cam_p[3]),1)
 	p[m-2+12],p[m-1+12]=
 	(p[m-2]-cam_p[1])*r+64,
 	(p[m-1]-cam_p[2])*r+64	 	
	end
	return p
end
function cube
(a,b,
 w2,l2,
 w1,l1,
 r,
 c,
	rez,
	top,
	bott,
	is_env)
	x1,y1,z1,x2,y2,z2,rr=a[1],a[2],a[3],b[1],b[2],b[3],r
	local ydif,rx,rz,ry=sgn(y1-y2),angle(x1,y1,x2,y2)*-1,char_rot,angle(y1,z1,y2,z2)
 if p==2 then
  rz*=-1
 end
 if ydif<0 then
 		rx+=0.5
 	end
		rx-=0.25
		rz-=0.5
		ry*=-1
 if is_env then rz=0 end
	 local a,b = 
	  quad(
			x1,y1,z1,
			w1,l1,
			ry,rz+rr,rx,
			col), 
			quad(
		 x2,y2,z2,
			w2,l2,
			ry,rz+rr,rx,
			col)
	rezz=rez
	if is_env then rezz=rez*4
	else
		rezz=rez
	end
	fillq(
	{a[13],a[14],
		a[16],a[17],
		b[13],b[14],
		b[16],b[17]},
		nsrfz(
				a[1],a[2],a[3],
  		a[4],a[5],a[6],
  		b[1],b[2],b[3]),
		c,true)
	fillq(
	{a[22],a[23],
 	a[19],a[20],
 	b[22],b[23],
 	b[19],b[20]},
	 nsrfz(
				a[10],a[11],a[12],
		  a[ 7],a[ 8],a[ 9],
		  b[10],b[11],b[12]),
	 c,false)
	fillq(
	{a[19],a[20],
		a[16],a[17],
		b[19],b[20],
		b[16],b[17]},
		nsrfz(
				a[7],a[8],a[9],
		  a[4],a[5],a[6],
		  b[7],b[8],b[9]),
		c,false)
	if top==1 then
		fillq(
		{b[13],b[14],
			b[16],b[17],
			b[22],b[23],
			b[19],b[20]},
			nsrfz(
				b[ 1],b[ 2],b[ 3],
		  b[ 4],b[ 5],b[ 6],
		  b[10],b[11],b[12]),
			c,true)
	end
	if bott==1 then
		fillq(
	 {a[13],a[14],
	  a[16],a[17],
	  a[22],a[23],
	  a[19],a[20]},
	  nsrfz(
				a[ 1],a[ 2],a[ 3],
		  a[ 4],a[ 5],a[ 6],
		  a[10],a[11],a[12]),
	  c,false)
	end
		fillq(
		{a[22],a[23],
	 	a[13],a[14],
	 	b[22],b[23],
	 	b[13],b[14]},
	 	nsrfz(
				a[10],a[11],a[12],
 			a[1 ],a[2 ],a[3 ],
 			b[10],b[11],b[12]),
	 	c,true)
end
function mix(x,y,p) return y*p+x*(1-p) end
function dist2(x1,y1,x2,y2)
	return sqrt(((x1-x2)^2)+((y1-y2)^2)) 
end
function dist3(x1,y1,z1,x2,y2,z2)
	return sqrt(((x1/10-x2/10)^2)+((y1/10-y2/10)^2)+(z2/10-z1/10)^2)
end
function angle(x1,y1,x2,y2)
	 return atan2(x2 - x1, y2 - y1)
end
function cossimil(a,b)
	local dot=(a[1]*b[1]+a[2]*b[2])
	local mag1=sqrt(a[1]^2+a[2]^2)
	local mag2=sqrt(b[1]^2+b[2]^2)
	return dot/(mag1*mag2)
end
function sideline(px,py,x1,y1,x2,y2)
	return (px-x1)*(y2-y1)-(py-y1)*(x2-x1)
end
function nsrfz
(x1,y1,z1,
	x2,y2,z2,
	x3,y3,z3)
 local yy, yyy = y2-y1, y3-y1
	local nx=((yy)*(z3-z1)-(z2-z1)*yyy)*0.001
	return nx/sqrt(nx^2+(((x2-x1)*(yyy)-(yy)*(x3-x1))*0.001)^2)
end
function fillq
	(v,s,c,t)
	if shoelace(v)==t then
		color(shade(s,c))
		local poly={
			{v[3],v[4]},
			{v[1],v[2]},
			{v[5],v[6]},
			{v[7],v[8]}}
		local nv,spans=#poly,{}
		for i,p1 in pairs(poly) do
			local p0=poly[i%nv+1]
			local x0,y0,x1,y1=p0[1],p0[2],p1[1],p1[2]
			if(y0>y1) x0,y0,x1,y1=x1,y1,x0,y0
			local cy0,dx=y0\1+1,(x1-x0)/(y1-y0)
			if(y0<0) x0-=y0*dx y0=0 cy0=0
			-- sub-pix shift
			x0+=(cy0-y0)*dx
			if(y1>127) y1=127
			for y=cy0,y1 do
				local span=spans[y]
				if span then
					rectfill(x0,y,span,y)
				else
					spans[y]=x0
				end
				x0+=dx
			end
		end			
		fillp()
	end
end
function shade(s,col)
	local a=abs(s)
	if a>0.85 then 
	 fillp(0b101101001011010) 
	end
	return sget(a*6.5599,col)
end
function shoelace(v)
	if ((v[1]*v[4]-v[3]*v[2])+(v[3]*v[6]-v[5]*v[4])+(v[5]*v[2]-v[1]*v[6]))>0 then return true else return false end
end
function depths()
	refl_centers,centers={},{}
	for i=1,#qubs do
		local q1,q2=qubs[i][1],qubs[i][2]
		add(refl_centers,
		{(q1[1]+q2[1])/4,
		 (q1[2]+q2[2])/4,
		 (q1[3]+q2[3])/4})
		add(centers,
		{(q1[1]+q2[1])/6,
		 (q1[2]+q2[2])/6,
		 (q1[3]+q2[3])/6})
	end
 distances={}
 for i=1,#centers do
 	add(distances,{i,dist3
 	(
 	 centers[i][1],centers[i][2],
 	 centers[i][3],cam_p[1],
 	 cam_p[2],cam_p[3]
 	)})
 end
 f={}
 for g=1,#distances do
	 local a={0,0,0}
	 for i=1,#distances do
	 	if distances[i][2]>a[2] then
    		a={distances[i][1],distances[i][2],i}
	 	end
	 end
	 add(f,a)
	 deli(distances,a[3])
	end
end
function draw_fighter(player)
	is_env=player == 3
	x,y,z,qubs=ppos[player][1],ppos[player][2],ppos[player][3],qbss[player]
	depths()
	if player==1 or player ==2 then
		draw_reflection(player)
	end
	for i=1,#qubs do
		local qfi1=qubs[f[i][1]]
		if qfi1[8]>-1 then
			local ccc=1
			if player == 1 or player == 2 then
				ccc=p_cols[player][f[i][1]]
			else
				ccc=qfi1[8]
			end
			cube
			(
				qfi1[1],
				qfi1[2],
				qfi1[3],
				qfi1[4],
				qfi1[5],
				qfi1[6],
				qfi1[7],
				ccc,
				qfi1[9],
				qfi1[10],
				qfi1[11],
				is_env														
			)
		end
	end	
end
function point_to_2d(v)
	local sr1,cr1,cx,cy=sin(cam_r1),cos(cam_r1),cam_p[2],cam_p[3]*-2	
	ppx,ppy=v[2]-cx,v[3]-cy
	local px1,py1=ppx*cr1-ppy*sr1,ppx*sr1+ppy*cr1
	v[2],v[3]=px1+cx,py1+cy
 local r=
 64/max((v[3]-cam_p[3]),1)
 local xx,yy=
 (v[1]-cam_p[1])*r+64,
 (v[2]-cam_p[2])*r+64
 return({xx,yy})
end

function rect3d(x,y,z,w,l,c)
	local p=point_to_2d({x,y,z})
	rectfill(p[1],p[2],p[1]+w,p[2]+l,c)
end
-->8
--gameplay
function gameplay()
	char_rot=angle(ppos[1][1],ppos[1][3],ppos[2][1],ppos[2][3])*-1
	if game_state=="editor"then	
		if chosen then
			char_rot=0.4
		else
			char_rot=-0.1
		end
	end
	if game_state=="menu" or game_state=="selector" then
		char_rot=0.4-g_time*0.1
	end
	
	early_pos,f_center={{ppos[1][1],ppos[1][3]},
							{ppos[2][1],ppos[2][3]}},{(ppos[1][1]+ppos[2][1])/2,
							(ppos[1][2]+ppos[2][2])/2,
							(ppos[1][3]+ppos[2][3])/2}
	for i=0,1 do
		local p=i+1
		hit[p],spd=false,1.3*stamina[p]*(game_speed*3.5)
		if p_action[p]=="idle"
		and (game_state=="solo"
				or game_state=="versus")
		then
			if i==0 or (i==1
			and game_state=="versus")
			then
				if btn(0,i) then
					ppos[p][1]-=spd
				end
				if btn(1,i) then
					ppos[p][1]+=spd
				end
				if btn(2,i) then
					ppos[p][3]+=spd
				end
				if btn(3,i) then
					ppos[p][3]-=spd
				end
			end
			if  game_state=="solo"
			and p_action[2]=="idle"
			then
				ai_move_x,ai_move_y=
					spd*0.5*sgn(sin(char_rot+0.25)),
					spd*0.5*sgn(sin(char_rot))
				ai_move_x_s+=(ai_move_x-ai_move_x_s)/30
				ai_move_y_s+=(ai_move_y-ai_move_y_s)/30
				if f_dist>33
				and ai_state=="approach"
				then
					ppos[2][1]+=ai_move_x_s
					ppos[2][3]+=ai_move_y_s
				end
				if (ai_state=="avoid_l"
				or ai_state=="avoid_r")
				and f_dist>30
				then
					if ai_state=="avoid_l"
					then
						ai_move_x_a,ai_move_y_a=
							spd*0.5*sgn(sin(char_rot+0.5)),spd*0.5*sgn(sin(char_rot+0.25))
					else
						ai_move_x_a,ai_move_y_a=spd*0.5*sgn(sin(char_rot)),spd*0.5*sgn(sin(char_rot+0.75))
					end
					ai_move_x_a+=(ai_move_x-ai_move_x_a)/30
					ppos[2][1]+=ai_move_x_a
					ppos[2][3]+=ai_move_y_a
				end
				if ai_state=="flee"
				then
					ppos[2][1]-=ai_move_x_s
					ppos[2][3]-=ai_move_y_s
				end
			end
		end
		ppos[p][3],ppos[p][1]=min(max(ppos[p][3],5),80),min(max(ppos[p][1],-80),80)
		if game_state=="solo" then
			ppos[2][3],ppos[2][1]=min(max(ppos[2][3],3),78),min(max(ppos[2][1],-78),78)
		end
		if (game_state=="solo"
				or game_state=="versus")
		then
			if ((btn(5,i)
							and game_state=="versus")
			or	(i==0
							and btn(5,0)
						 and game_state=="solo")
			or (i==1
							and ai_state=="punch"
							and game_state=="solo"))
			and p_action[p]=="idle"then
				if p_action[p]!="punch1" then
					p_action[p],frame[p],nextframe[p]="punch1",1,2
					stamina[p]-=0.02
				end
			end
			if ((btn(4,i)
							and game_state=="versus")
			or	(i==0
							and btn(4,0)
						 and game_state=="solo")
			or (i==1
							and ai_state=="kick"
							and game_state=="solo"))
			and p_action[p]=="idle" then
				frame[p],nextframe[p],step[p],p_action[p]=1,2,0,"kick1"
				stamina[p]-=0.08
			end
		end
	end
	dpos={{ppos[1][1]-early_pos[1][1], ppos[1][3]-early_pos[1][2]},
							{ppos[2][1]-early_pos[2][1], ppos[2][3]-early_pos[2][2]}}
	dpos={dpos[1],dpos[2],angle(dpos[1][1],dpos[1][2],0,0),angle(dpos[2][1],dpos[2][2],0,0)}
	for i=1,2 do
		if i == 1 then
			other_player=2
		else
		 other_player=1
		end
		if (dpos[i][1]!=0 or dpos[i][2]!=0) and p_action[i]=="idle" and game_state!="editor" then
			local vect,vect2 ={dpos[i][1],dpos[i][2]},{f_center[1]-ppos[i][1],f_center[3]-ppos[i][3]}
			local css=cossimil(vect,vect2)
			if i==1 then
				ppf,ppc,other_player=2,1,2
			else
				ppf,ppc,other_player=1,2,1
			end
			local sl=sideline(
		 ppos[ppf][1],ppos[ppf][3],ppos[ppc][1],ppos[ppc][3],ppos[ppc][1]+dpos[ppc][1],ppos[ppc][3]+dpos[ppc][2])
	 	if abs(css) >0.9 then
	 		if css>0.5 then
	 			animate(2,1.2,i)
	 		else
	 			animate(3,1.2,i)
	 		end
	 	else
	 		if sl>0 then
	 			animate(5,1.25,i)
	 		else
	 			animate(4,1.25,i)
	 		end
	 	end
		else
			if p_action[i]=="block" then
				animate(9,0.3,i,true)
				if hp[i] == 0 then
					p_action[i]="idle"
				end
				if (game_state=="versus"
								and((btn(4,i-1) and btn(5,i-1))==false))
							or
							(
								game_state=="solo"
								and(
									(i==1
										and(
									(btn(4,0) and btn(5,0))==false
								)
									)
									or
									(
										i==2
										and(
											ai_state!="block"
										)
									)
								)
							)
				then
					p_action[i]="exit_block"
					rst_anim(i)
				end
			elseif p_action[i]=="punch1" then
				animate(6,1.4,i,false)
				if frame[i] == 6 or frame[i] == 9 or frame[i] == 11 then
					next_punch[i]=false
					stamina[i]-=0.0055
				end
				if (frame[i] > 3 and frame [i] < 6) and (btn(5,i-1) or (i==2 and ai_state=="punch" and game_state=="solo")) then
					next_punch[i]=true		
				elseif (frame[i] > 6 and frame [i] < 9) and (btn(5,i-1) or (i==2 and ai_state=="punch" and game_state=="solo")) then
					next_punch[i]=true
				end
				if not next_punch[i] then
					if frame[i]==5 then
						p_action[i]="punch1_2_idle"
						rst_anim(i)
					elseif frame[i]==8 then
						p_action[i]="punch2_2_idle"
						rst_anim(i)
					end
				end
			elseif p_action[i]=="hit1" then
				animate(7,1.2,i,false)
			elseif p_action[i]=="hit2" then
				animate(11,1.5,i,false)
			elseif p_action[i]=="hit3" then
				animate(12,1.6,i,false)
				die_after_hit(i,12)
				if i == 1 then 
					otherpl = 2
				else
					otherpl = 1
				end
				if p_action[otherpl] != "kick1"
				then
					if hp[i] <= 50 then
						game_speed=0.05
					end
				end
			elseif p_action[i]=="punch1_2_idle" then
				animate(13,1.2,i,false)
				if nextframe[i]==1 then
					p_action[i]="idle"
					rst_anim(i)
				end
			elseif p_action[i]=="punch2_2_idle" then
				animate(14,1,i,false)
				if nextframe[i]==1 then
					p_action[i]="idle"
					rst_anim(i)
				end
			elseif p_action[i]=="enter_block" 
			then
				if hp[i] > 0 then
					animate(8,0.5,i,false)
					if step[i]>0.5 then
						p_action[i]="block"
					end
				else
					p_action[i]="dead"
				end
			elseif p_action[i]=="exit_block" then
				animate(16,0.5,i,false)
				if frame[i]==1 and step[i]>0.5 then
					p_action[i]="idle"
				end
			elseif p_action[i]=="kick1" then
				animate(15,2,i,false)
				if frame[i]==1 then
					next_kick[i]=false
				end
				if (frame[i]>2 and frame[i]<6) and (btnp(4,i-1) or (i==2 and game_state=="solo" and ai_state=="kick")) then
					next_kick[i]=true
				end
				if frame[i]==12 and next_kick[i] then
					rst_anim(i)
					p_action[i]="kick2"
				end
			elseif p_action[i]=="kick2" then
				animate(17,1.8,i,false)
			elseif p_action[i]=="won" then
				local spdddd=0.7
				if i==2 then spdddd=0.4 end
				animate(21,spdddd,i,true)
			elseif p_action[i]=="won_transition" then
				animate(20,1,i,false)
				if  frame[i] == 3 and step[i] > 0.1 then
					p_action[i]="won"
					rst_anim(i)
				end
			elseif (p_action[i]=="idle" or p_action[i]=="dead")
			then
				game_speed=0.2
				if hp[i]<0.1 then
					if not death then
				 		animate(18,0.6,i,true)
		 		 	p_action[i]="dead"
						if frame[i]==7 then
							death,p_action[other_player]=true,"won_transition"
							rst_anim(i)
							rst_anim(other_player)
						end
					else
						stamina[other_player]=1.3
						animate(19,0.2,i,true)										
						if p_action[other_player]=="won_transition" then
							animate(20,0.01,other_player,true)
						end
					end
				else
					animate(1,0.4,i)
					next_punch[i]=false
				end
			end
		end
		if p_action[i]=="idle" or (p_anim[i]==2 or p_anim[i]==3 or p_anim[i]==4 or p_anim[i]==5) then
			stamina[i]+=0.01
		end
		if stamina[i]<0.82 then
			if g_time%0.2>0.15 and p_action[i] != "dead" then
				add_particle(player,ppos[i],-26,1,0,0.1,12)
			end
		end
	end
	if	 p_action[1] != "hit3"
	and p_action[2]	!= "hit3"
	then
		game_speed=0.2
	end
	ddd,f_dist=dist2(f_center[1],f_center[3],cam_p[1],cam_p[3]),max(dist2(ppos[1][1],ppos[1][3],ppos[2][1],ppos[2][3]),30)
	cam_r1,cam_p=min(mix(-0.16,0,ddd/100),-0.06)-(f_dist*0.0001)+0.03,{(ppos[1][1]+ppos[2][1])/2,f_dist*0.1-5,f_dist*-0.5-30+(fade_time/7)*30}
	for i=1,2 do
		if stamina[i]<0.7 then
			stamina[i]=0.7
		elseif stamina[i]>1 then
			stamina[i]=1
		end
		if i == 1 then
			other_player=2
		else
			other_player=1
		end
		if
			(
				(
					game_state=="solo"
					and
					(
						(i==1 and (btn(4,0) and btn(5,0)))
						or
						(
							i==2 and ai_state=="block"
						)
					)
				)
				or
				(
					game_state=="versus"
					and
					(
						btn(4,i-1) and btn(5,i-1)
					)
				)
			)
			and p_action[i] != "enter_block"
			and p_action[i] != "block"
			and p_action[i] != "hit1"
			and p_action[i] != "hit2"
			and p_action[i] != "hit3"
			and p_action[i] != "dead"
			and p_action[i] != "won_transition"
			and p_action[i] != "won"
			then
				rst_anim(i)
				p_action[i] = "enter_block"
				if step[i]>0.5 then
						p_action[i]="block"					
				end
		end
		if f_dist < 47 then
			if  (p_anim[i] == 15
			and	frame[i] == 5)
			or (p_anim[i] == 17
			and	frame[i] == 8)
			then
				if hp[other_player]>0 
				then
					if 
					p_action[other_player]==
					"block"
					then
						hp[other_player]-=0.5
						animate(10,1,other_player,false)
						camshake()
						hit[other_player]=not hit[other_player]
					else
						if p_action[other_player]!="enter_block"
						then
							hp[other_player]-=1
							hit[other_player]=not hit[other_player]
							p_action[other_player]="hit3"
							camshake()	
							for i=1,3 do
									add_particle(other_player,
									ppos[other_player],
										-26,
										-1,
										6,
										0.2,
										7)
								end
						end
					end
				end
			end
		end
		if f_dist < 36 then
			if  p_anim[i] == 6
			and (frame[i]  == 4
			or frame[i] == 7
			or frame[i] == 11)
			then
				frm = frame[i]
				if hp[other_player]>0 
				then
					if p_action[other_player]=="block"
					then
						hp[other_player]-=0.5
						camshake()
						animate(10,1,other_player,false)
					else
						if p_action[other_player]!="enter_block"
						then
							hp[other_player]-=1
							camshake()
							if frm == 4 then
								p_action[other_player]="hit1"
								for i=1,3 do
									add_particle(other_player,
									ppos[other_player],
										-26,
										3,
										0,
										0.6,
										7)
								end
							elseif frm == 7 then
								p_action[other_player]="hit2"
								for i=1,3 do
									add_particle(other_player,
									ppos[other_player],
										-26,
										3,
										0,
										0,
										7)
								end
							elseif frm == 11 then
								p_action[other_player]="hit3"
								for i=1,3 do
									add_particle(other_player,
									ppos[other_player],
										-26,-1,6,0.2,7)
								end
							end
						end
					end
					hit[other_player]=not hit[other_player]
				end
			end
		end
		if game_state=="menu"
		or game_state=="selector"
		then
			animate(23,1,i)			
			local posss={{-8,38},{8,22}}
				local xx,pf,c,s=posss[i][1],posss[i][2]-30,cos(g_time*0.1+0.2),sin(g_time*0.1+0.2)
				ppos[i][1],ppos[i][3]=c*xx-s*pf,s*xx+c*pf+30
		end
		if hp[i]<0 then hp[i]=0 end
	end
end
function add_particle(
			player,v,h,s,sy,dirx,colr)
	if count(particles)<56
	then
		particle=
		{
			p						=	player,
			x						=	v[1],
			y 					= v[2]+h,
			z						=	v[3],
			prev_x = x,
			prev_y = y,
			prev_z = z,
			life 		= 8,
			speed		=	s,
			speedy	=	sy,
			init_s = s,
			dx				 = dirx,
			rndom1 = rnd(4),
			rndom2 = rnd(4),
			rndom3 = rnd(4),
			colll		= colr
		}
		add(particles,particle)
	end
end
function draw_particles()
	for p in all(particles)
	do
		p.prev_x,p.prev_y,p.prev_z=p.x,p.y,p.z
		if p.speed>0
		then
			p.speed-=game_speed
		end
		if p.speedy>0
		then
			p.speedy-=game_speed
		end
		if p.y<12
		then
			p.y+=4-p.speedy-p.rndom3*0.2
		end
		local coords2=point_to_2d(
			{p.prev_x,
				p.prev_y,
				p.prev_z})
		if p.p==2 then
			chr_rot=char_rot
		else
			chr_rot=char_rot+0.5
		end
		if p.y<12
		then
			p.x += (p.speed/p.init_s)*((p.rndom1-2)*(p.life/5+0.1))+(sin(chr_rot*-1+p.dx))*p.speed
			p.z += (p.speed/p.init_s)*((p.rndom2-2)*(p.life/5+0.1))-(cos(chr_rot*-1+p.dx))*p.speed
			local coords=point_to_2d({p.x,p.y*-1+29,p.z})
			fillp(░)
			pset(coords[1],coords[2],7)
			fillp()
			local coords=point_to_2d({p.x,p.y,p.z})
			line(coords[1],coords[2],coords2[1],coords2[2],p.colll)	
			if p.colll==7
			then
			pset(coords[1]+rnd(10)-5,coords[2]+rnd(10)-5,p.colll)
			end
		end
		if p.life>0 then
			p.life-=0.1
		else
			del(particles,p)
		end
	end
end
function draw_particles_ground()
	for p in all(particles) do
		if p.y>12 then
			local coords=point_to_2d({p.x,p.y,p.z})
			circfill(coords[1],coords[2],(cam_p[3]-p.z+150)*0.01,0)
		end
	end
end
function camshake()
	camera(rnd()*2-1, rnd()*2-1)
end
function draw_reflection(p)
	fillp(░)
	pal(0,5)
	local xs,ys ={},{}
	for i=1,13 do
		local coords=point_to_2d(
			{(refl_centers[i][1]+cam_p[1]/2),
			(refl_centers[i][2]
					+cam_p[2]/2)
					*-1+13
					-cam_p[2]
					-cam_p[3]*0.05
					+f_dist*0.2,
				refl_centers[i][3]+cam_p[3]/2-5})
		add(xs,coords[1])
		add(ys,coords[2]-18)
	end
	local vars={{1,1,3,3,2},
		{2,2,3,3,3},
		{4,4,5,5,5},
		{6,6,5,5,6},
		{4,4,8,8,4},
		{1,1,8,8,4},
		{10,10,9,9,10},
		{11,11,12,12,12},
		{7,7,8,8,8},
		{13,13,8,8,7},
		{7,7,9,9,9},
		{7,7,11,11,11}}
 for i=-2,2 do
		for nb=1,12 do
			local varsnb=vars[nb]
			line(xs[varsnb[1]]+i,ys[varsnb[2]],xs[varsnb[3]]+i,ys[varsnb[4]],p_cols[p][varsnb[5]])
		end
	end		
		circfill(xs[13],
			ys[13],
		(cam_p[3]-ppos[p][3]
			+180)*0.021,
			p_cols[p][13])
	pal()
	fillp()
end
function die_after_hit(i,an)
	if 	hp[i]<1
	and frame[i]==#animations[an]
	then
		animate(18,0.6,i,true)
		rst_anim(i)
		p_action[i]="dead"
	end
end
-->8
--ui
function update_ui()
	if game_state=="solo" or game_state=="versus" then
		for i=1,2 do
			if hit[i] then
				hpcolll[i]=not hpcolll[i]
				if hpcolll[i] then hpcol[i]=7
				else hpcol[i]=hpcoll[i] end
			else
				hpcol[i]=hpcoll[i]
			end
		end
		palt(0,false)
		palt(14,true)
		pal(7,hpcol[1])
		pal(7,hpcol[2])
		palt()
		pal()
		rectfill(12,122,118,125,0)
		local hpi=fade_time/7
  rectfill(62-17*(hp[1]*0.03)*hpi,123,62,124,hpcol[1])
		rectfill(66,123,66+18*(hp[2]*0.03*hpi),124,hpcol[2])
		if death then
			if d_timer==0 then d_timer=g_time+7 end
			local winner=1
			if hp[1]==0 then
				winner=2
			end
			print("\fb\#1victory for fighter "..winner,24,110)
			game_speed=0.2
			if d_timer<g_time and d_timer != 0 then
				game_state,env="editor",0
			end
		end	
		fadeout(150)
	else
		fadeout(300)
	end
end
function draw_menu()
	if game_state=="menu"
	or game_state=="editor"
	or game_state=="selector"
	then
		arrow+=0.5
		palt()
		pal()
		local g_time2=g_time*0.2
		for i=	28,155 do
			local deform_x=60-i
			if i<50 then deform_x=80-i end
			local persp_y=(-abs(64-i)*20)/50
			--0,125 = 1 pixel
			tline(
			 -1,i-28,127,i-28, --screen location
				0,0.125*i/persp_y+g_time2,--map location
				0.0125/(deform_x*0.04),--add x
				0.00155--add y
			)
		end
		rectfill(0,25,127,43,1)
		fillp(▒)
		rectfill(0,21,127,48)
		fillp()
	end
	if  game_state=="menu"
	then
		sspr(0,64,128,42,0,fade_time*7-41)
		if btnp(❎)
		then
			game_state,timer="editor",g_time+0.5
		end
	end
	if game_state=="editor"
	then
		cam_p={63,0,-22}
		move_arrow(8)
		local plr=1
		if chosen
		then
			plr=2
		end
		print("\#b\f1colors\#1\fb\n\n…head\n…chest\n…arms\n…forearms\n…hips\n…thigs\n…legs\n…feet",15,15)
		local colllls={13,7,9,10,8,1,2,3}
		for i=1,8
		do
			print("\#b\f1"..p_cols[plr][colllls[i]],10,6*i+21)
		end
		if arrow>5 then arrow=0 end
		spr(116+arrow,-1,19+6.1*editor_y)
		if btnp(❎) and timer<g_time
		then
			editor_y,game_state,timer=1,"selector",g_time+1
		end
		if btnp(🅾️)
		and ppos[1][1]>55
		then
			if editor_y==2
			then
				p_cols[plr][7]+=1
			elseif editor_y==5
			then
				p_cols[plr][8]+=1
			elseif editor_y==3
			then
				p_cols[plr][9]+=1
				p_cols[plr][11]+=1
			elseif editor_y==6
			then
				p_cols[plr][1]+=1
				p_cols[plr][4]+=1
			elseif editor_y==7
			then
				p_cols[plr][2]+=1
				p_cols[plr][5]+=1
			elseif editor_y==8
			then
				p_cols[plr][3]+=1
				p_cols[plr][6]+=1
			elseif editor_y==1
			then
				p_cols[plr][13]+=1
			elseif editor_y==4
			then
				p_cols[plr][10]+=1
				p_cols[plr][12]+=1
			end
		end
		for y=1,2
		do
			for x=1,13
			do
					if p_cols[y][x]>16
					then
						p_cols[y][x]=1
					end
			end
		end
		death=false
		animate(24,0.01,1,true)
		animate(24,0.15,2,true)
		if btn(⬅️)
		then
			chosen=true
		end
		if btn(➡️)
		then
			chosen=false
		end
		if chosen
		then
			print("\#1\fb p2/cpu >",76,15)
			ppos[1],ppos[2]={(ppos[1][1]+30)/1.5,
												(ppos[1][2]+4)/1.5,
												(ppos[1][3]+30)/1.5},
										 {(ppos[1][1]+110)/1.5,
												(ppos[1][2]+5)/1.5,
												(ppos[1][3]-30)/1.5}
		else
			print("\#1\fb< p1  ",82,15)
		 ppos[1],ppos[2]={(ppos[1][1]+130)/1.5,
												(ppos[1][2]+4)/1.5,
												(ppos[1][3]+9)/1.5},
										 {(ppos[1][1]+10)/1.5,
												(ppos[1][2]+7)/1.5,
												(ppos[1][3]+60)/1.5}
		end
	end
	if game_state=="selector"
	then
		cam_p,locs={-40,-20,-260+sin(g_time)*10},{22,25,26}
		camera(8)
		animate(locs[switched_env],0,3,true)
		if btnp(❎) and timer<g_time 
		then
			game_state,timer="editor",g_time+1
		end
		if btn(🅾️)
		and timer<g_time
		then
			timer=g_time+0.2
			if editor_y==1
			then
				switch_mode()
			elseif (editor_y==2 and mode=="solo")
			then
				switch_difficulty()
			elseif editor_y==3
			then
				switch_map()
			elseif editor_y==4
			then
				start_fight()
				fade_time=1
			end
		end
		print("\#1\fbgame mode:"..mode
		.."\n\n\nstage:"..maps[switched_env].."\n\n\n\n\n\n\n\n\n\n\n\n▒start fight▒\n\n🅾️/z change         ❎ back",18,15)
		if mode=="solo"
		then
			print("\#1\fbai difficulty:"..levels[ai_level],18,24)
		else
			print("\#3\f1ai difficulty:"..levels[ai_level],18,24)
		end
		move_arrow(4)
		if arrow>5 then arrow=0 end
		if editor_y== 4 then
			spr(116+arrow,7,103)
		else
			spr(116+arrow,7,5+8.8*editor_y)
		end
		local vv=0
		if switched_env==3
		then
			camera(-4)
			vv=12
		end
		sspr(16*(switched_env-1),112,16,16,43-vv,54,56,38)
		draw_fighter(3)
	end
end
function switch_mode()
	if mode=="solo"
	then
		mode="versus"
	else
		mode="solo"
	end
end
function switch_difficulty()
	ai_level+=1
	if ai_level>3 then ai_level=1end
end
function switch_map()
	switched_env+=1
	if switched_env>3 then switched_env=1 end
end
function start_fight()
	env,game_state=switched_env,mode
 init_fight()
end
function move_arrow(x)
	if btnp(⬆️)
	then
	 if editor_y>1
		then
			editor_y-=1
		end
	end
	if btnp(⬇️)
	then
		if editor_y<x
		then
			editor_y+=1
		end
	end
end
function fadeout(x)
	for i=0,15 do
		if fade_time<6.5 then 
			if g_time>0.7 then
				fade_time-=(fade_time-7)/x
			end
			pal(i,sget(9-fade_time,i))			
		else
			fade_time=6.7
		end
		poke(0x5f10+i,128+i)
	end	
end
-->8
--data
function init_fight()
	game_speed,hp,death,p_action,p_anim,hit,next_punch,next_kick,stamina,cam_p,cam_r1,c1,c2,c3,particles,ppos,d_timer=
	0.2,{100,100},false,{"idle", "idle"},{0,0},{false,false},{false,false},{false,false},{1.3,1.3,1,3},{0,-31,0},-0.1,0,0,0,{},{{-40,10,43},{ 40,10,55},{0,0,70}},0
end
function init_data()
	init_fight()
	cls(6)poke(0x5f38, 4)poke(0x5f39, 4)poke(0x5f5c, 9)poke(0x5f5d, 4)
	mode,levels,maps,timer="solo",{"easy","normal","hard"},{"city","subway station","parking lot"},0					
 plane_x,p_cols,chosen,editor_y,arrow=100,{{7,8,1,7,8,1,1,7,8,15,8,15,8},{11,11,3,11,11,3,3,11,15,15,15,15,11},{}},false,1,0
 game_state,env,switched_env,flrc,flrot,fo,cols,pcol,qbss,panim,anim,frame,step,frame,nextframe,char_rots,f_dist,hpcol,hpcoll,hpcolll,fade_time,ai_vars=
 "menu",0,1,{0,12,90},{0,0,0},0,{},{8,12},{},{1,1,1},{2,2,2},{1,1,1},{1,1,1},{1,1,1},{1,1,1},{0,0},0,{8,8},{11,11},{true,true},1,{"","approach","flee","avoid_l","avoid_r","idle","approach","flee","avoid_l","avoid_r","kick","punch","idle","block"}
animations={
--1 idl
[[
-9,-8,3,-10,3,-2,-15,12,7,-13,12,1,-3,-7,7,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,4,4,-25,4,6,-16,11,12,-14,3,-5,-26,-1,-12,-21,1,-6,-14,-5,0,0,0,2,-30,1,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-7,-9,3,-10,0,-2,-15,11,7,-13,12,1,-1,-8,7,6,-1,7,5,10,8,10,12,7,0,0,0,-3,-15,5,4,-27,3,6,-19,11,14,-14,8,-5,-28,0,-11,-22,-2,-4,-19,-9,0,0,0,2,-33,1,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-6,-6,3,-10,2,-2,-15,11,7,-13,12,1,0,-5,7,8,-1,8,5,10,8,10,12,7,0,0,0,-2,-11,4,5,-24,4,8,-16,11,16,-16,10,-4,-24,-2,-11,-19,-5,-3,-18,-9,0,0,0,3,-30,1,0.01,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-7,-7,3,-9,4,0,-15,12,7,-13,12,1,-1,-6,7,8,0,8,5,11,8,10,12,7,0,0,0,-3,-12,4,6,-23,5,6,-15,9,13,-14,5,-3,-25,-2,-10,-19,-3,-3,-15,-9,0,0,0,4,-29,1,0.01,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499
]],
--2 mv fw
[[
-9,-10,5,-13,-1,-1,-17,7,7,-15,7,1,-3,-9,9,3,0,8,4,11,8,9,11,7,0,0,0,-5,-16,7,4,-28,5,7,-20,13,12,-15,4,-5,-29,0,-14,-23,4,-5,-16,-4,0,0,0,2,-33,2,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-9,-6,5,-7,0,0,-8,11,8,-7,11,1,-3,-5,9,5,0,8,-1,11,8,4,11,7,0,0,0,-5,-12,7,4,-24,3,6,-14,10,12,-13,3,-5,-25,-2,-14,-20,1,-6,-13,-5,0,0,0,2,-29,0,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-9,-7,5,-11,2,2,-14,11,8,-12,11,2,-3,-6,9,4,-2,8,1,8,8,7,8,7,0,0,0,-5,-13,7,3,-25,4,6,-15,11,11,-11,3,-6,-26,-1,-13,-21,1,-6,-14,-5,0,0,0,1,-30,1,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499
]],
--3 mv bk
[[
-9,-7,5,-11,2,2,-14,11,8,-12,11,2,-3,-6,9,4,-2,8,1,8,8,7,8,7,0,0,0,-5,-13,7,3,-25,4,6,-15,11,11,-11,3,-6,-26,-1,-13,-21,1,-6,-14,-5,0,0,0,1,-30,1,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-9,-7,5,-7,0,0,-8,11,8,-7,11,1,-3,-6,9,5,0,8,-1,11,8,4,11,7,0,0,0,-5,-13,7,4,-25,4,6,-15,11,14,-14,4,-5,-26,-1,-14,-21,2,-5,-14,-4,0,0,0,2,-30,1,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-9,-10,5,-13,-1,-1,-17,7,7,-15,7,1,-3,-9,9,3,0,8,4,11,8,9,11,7,0,0,0,-5,-16,7,4,-28,5,7,-20,13,12,-15,4,-5,-29,0,-14,-23,4,-5,-16,-4,0,0,0,2,-33,2,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499
]],
--4 mv r
[[
-7,-8,6,-8,0,0,-13,3,11,-11,7,7,-1,-7,10,5,0,8,5,11,8,10,12,7,0,0,0,-3,-13,7,6,-25,8,6,-18,14,14,-12,9,-3,-26,3,-11,-20,1,-4,-14,-1,0,0,0,4,-30,5,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-9,-8,3,-10,2,0,-15,12,1,-13,12,-5,-3,-7,7,4,1,9,5,11,12,10,12,11,0,0,0,-5,-13,4,3,-25,6,5,-16,13,11,-12,7,-5,-26,1,-12,-21,3,-6,-14,-3,0,0,0,2,-30,3,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-10,-9,3,-10,3,-2,-15,12,7,-13,12,1,-4,-8,7,4,-2,8,1,7,11,6,8,10,0,0,0,-8,-14,4,1,-26,6,3,-17,13,9,-15,5,-8,-27,1,-15,-22,3,-9,-15,-3,0,0,0,-1,-31,3,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-9,-9,3,-10,3,6,-15,9,12,-13,12,7,-3,-8,7,4,1,4,5,12,0,11,10,-1,0,0,0,-7,-14,4,0,-26,8,0,-19,14,8,-12,8,-6,-27,0,-13,-21,0,-6,-15,-2,0,0,0,0,-31,3,0.06,0,0.1199,0,0,0,-0.0799,-0.1399,0,0,0,0,-0.0499
]],
--5 mv l
[[
-9,-9,3,-10,3,6,-15,9,12,-13,12,7,-3,-8,7,4,1,4,5,12,0,11,10,-1,0,0,0,-7,-14,4,0,-26,8,0,-19,14,8,-12,8,-6,-27,0,-13,-21,0,-6,-15,-2,0,0,0,0,-31,3,0.06,0,0.1199,0,0,0,-0.0799,-0.1399,0,0,0,0,-0.0499/
-10,-9,3,-10,3,-2,-15,12,7,-13,12,1,-4,-8,7,4,-2,8,1,7,11,6,8,10,0,0,0,-8,-14,4,1,-26,6,3,-17,13,9,-15,5,-8,-27,1,-15,-22,3,-9,-15,-3,0,0,0,-1,-31,3,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-9,-8,3,-10,2,0,-15,12,1,-13,12,-5,-3,-7,7,4,1,9,5,11,12,10,12,11,0,0,0,-5,-13,4,3,-25,6,5,-16,13,11,-12,7,-5,-26,1,-12,-21,3,-6,-14,-3,0,0,0,2,-30,3,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-7,-8,6,-8,0,0,-13,3,11,-11,7,7,-1,-7,10,5,0,8,5,11,8,10,12,7,0,0,0,-3,-13,7,6,-25,8,6,-18,14,14,-12,9,-3,-26,3,-11,-20,1,-4,-14,-1,0,0,0,4,-30,5,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499
]],
--6 punch 1
[[
-10,-8,4,-10,3,-2,-15,12,7,-13,12,1,-2,-7,6,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,4,4,-25,5,6,-16,12,12,-14,4,-5,-26,0,-12,-21,1,-6,-14,-4,0,0,0,2,-30,2,0.06,0,0.1199,0,0,0,-0.1299,-0.1399,0,0,0,0,-0.0499/
-10,-6,3,-11,4,-5,-15,12,7,-13,12,1,-4,-5,7,4,1,8,5,11,9,10,12,7,0,0,0,-7,-11,4,-4,-23,5,3,-19,4,6,-13,-4,-13,-24,3,-16,-16,8,-14,-12,-1,0,0,0,-6,-29,3,0.06,0,0.1199,0,0,0,-0.2998,-0.1399,0,0,0,0,-0.0499/
-5,-8,1,-8,2,2,-17,9,6,-13,12,1,-3,-7,8,1,1,8,4,11,9,9,12,7,0,0,0,-3,-13,4,6,-25,10,-5,-19,19,7,-15,13,1,-26,-1,-11,-24,-6,-2,-22,-14,0,0,0,7,-30,5,0.06,0,0.1199,0,0,0,0.01,-0.0099,0,0,0,0,-0.0499/
-3,-9,1,-9,2,2,-17,8,4,-13,12,1,-4,-8,8,0,1,8,4,11,9,9,12,7,0,0,0,-3,-14,4,-2,-26,7,-8,-19,13,0,-18,12,7,-26,0,15,-26,-5,23,-27,-5,0,0,0,6,-31,4,0.06,0,0.1199,0,0,0,0.1,0.07,0,0,0,0,-0.0499/
-4,-9,1,-6,2,2,-16,8,4,-13,12,1,-5,-7,8,0,1,8,4,11,9,9,12,7,0,0,0,-4,-13,4,-2,-26,10,-10,-20,14,-12,-14,16,8,-25,4,7,-16,6,-4,-12,13,0,0,0,6,-31,7,0.06,0,0.1199,0,0,0,0.1999,0.06,0,0,0,0,-0.0499/
-4,-8,0,-6,3,2,-16,8,5,-13,12,1,-5,-7,8,0,1,8,4,11,9,9,12,7,0,0,0,-4,-13,4,-1,-27,10,-8,-28,14,-9,-23,21,4,-25,-2,4,-15,-1,-1,-17,10,0,0,0,5,-30,5,0.06,0,0.1199,0,0,0,0.1,0.05,0,0,0,0,-0.0499/
-7,-6,0,-10,1,-2,-16,10,6,-13,12,1,-4,-7,8,2,1,7,4,11,10,9,12,7,0,0,0,-4,-13,4,7,-26,10,18,-27,10,31,-29,8,-5,-25,-1,-10,-16,-2,-2,-16,-2,0,0,0,4,-31,6,0.06,0,0.1199,0,0,0,-0.0998,0,0,0,0,0,-0.0499/
-7,-6,0,-10,1,-4,-17,10,5,-13,12,1,-4,-7,8,2,1,6,4,11,10,9,12,7,0,0,0,-4,-13,4,1,-25,3,11,-22,2,10,-20,-10,-9,-24,-2,-14,-16,3,-6,-16,-8,0,0,0,-1,-30,2,0.06,0,0.1199,0,0,0,-0.11,-0.07,0,0,0.1499,0,-0.0499/
-6,-6,-1,-10,2,-1,-19,9,5,-13,12,1,-4,-7,8,3,1,7,4,11,10,9,12,7,0,0,0,-4,-13,4,-1,-23,8,5,-17,5,5,-16,-4,-5,-24,-4,-17,-19,1,-16,-11,-3,0,0,0,0,-29,3,0.06,0,0.1199,0,0,0,-0.0301,-0.09,0,0,0,0,-0.0499/
-4,-6,0,-10,2,1,-19,9,5,-13,12,1,-3,-7,9,6,0,8,4,11,10,9,12,7,0,0,0,-3,-13,4,-4,-26,9,3,-22,14,8,-16,3,4,-24,-2,-1,-16,-5,2,-9,-5,0,0,0,1,-29,3,0.06,0,0.1199,0,0,0,0.06,-0.01,0,0,0,0,-0.0499/
-3,-7,0,-9,1,1,-18,9,4,-13,12,1,0,-8,9,5,1,10,4,11,10,9,12,7,0,0,0,-1,-14,4,0,-27,6,-7,-19,9,6,-21,5,9,-26,-1,19,-24,-2,26,-30,-2,0,0,0,7,-32,2,0.06,0,0.1199,0,0,0,0.1399,0,0,0,0,0,-0.0499/
-4,-7,0,-7,1,1,-17,8,4,-13,12,1,-1,-8,9,4,1,10,4,11,10,9,12,7,0,0,0,-2,-14,4,-3,-26,6,-9,-19,9,0,-17,13,6,-25,-1,15,-26,-2,18,-34,-2,0,0,0,4,-31,3,0.06,0,0.1199,0,0,0,0.1099,-0.03,0,0,0,0,-0.0499/
-6,-7,0,-7,1,-4,-16,7,5,-14,11,1,-1,-8,8,5,1,8,4,12,10,9,12,7,0,0,0,-4,-14,4,-2,-26,7,-2,-17,10,11,-11,6,3,-25,-2,10,-22,-5,20,-23,-2,0,0,0,3,-31,3,0.06,0,0.1199,0,0,0,0.09,-0.09,0,0,0,0,-0.0499/
-10,-7,2,-9,0,-3,-16,10,6,-13,12,1,-2,-7,8,6,0,8,4,12,10,9,12,7,0,0,0,-6,-13,4,-2,-26,8,-6,-19,13,7,-15,6,0,-25,-3,-5,-16,-5,5,-17,-2,0,0,0,1,-31,3,0.06,0,0.1199,0,0,0,0.02,-0.08,0,0,0,0,-0.0499
]],
--7 hit1
[[
-9,-8,3,-10,3,-2,-15,12,7,-13,12,1,-3,-7,7,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,4,4,-25,4,6,-16,11,12,-14,3,-5,-26,-1,-12,-21,1,-6,-14,-5,0,0,0,2,-30,1,0.06,0,0.1199,0,0,0,-0.1499,-0.1399,0,0,0,0,-0.0499/
-11,-8,4,-12,3,-2,-15,12,7,-13,12,1,-2,-7,5,3,0,8,5,11,8,10,12,7,0,0,0,-5,-15,4,3,-25,0,6,-16,9,15,-14,8,-7,-26,-1,-15,-18,-2,-6,-10,-7,0,0,0,-1,-31,1,0.06,0,0.1199,0,0,0,-0.1499,-0.1399,0,0,0,0,-0.0499/
-11,-7,4,-12,4,-3,-15,12,7,-13,12,1,-2,-6,5,5,0,8,5,11,8,10,12,7,0,0,0,-5,-12,3,2,-23,-5,6,-22,3,14,-16,8,-8,-24,-6,-13,-16,-8,-3,-12,-15,0,0,0,-2,-29,-8,0.06,0,0.1199,0,0,0,-0.1499,-0.1399,0,0,0,0,-0.0499/
-11,-8,4,-12,3,-2,-15,12,7,-13,12,1,-2,-7,5,3,0,8,5,11,8,10,12,7,0,0,0,-5,-15,4,3,-25,0,6,-16,9,15,-14,5,-7,-26,-1,-15,-18,-1,-6,-14,-10,0,0,0,0,-29,-5,0.06,0,0.1199,0,0,0,-0.1499,-0.1399,0,0,0,0,0.0101
]],
--8 enter_block
[[
-9,-8,3,-10,3,-2,-15,12,7,-13,12,1,-3,-7,7,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,4,4,-25,4,6,-16,11,12,-14,3,-5,-26,-1,-12,-21,1,-6,-14,-5,0,0,0,2,-30,1,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-11,-8,3,-13,-1,-1,-15,12,7,-13,12,1,-5,-7,7,2,0,6,5,11,8,10,12,7,0,0,0,-9,-13,4,-2,-23,4,2,-19,-2,1,-28,-2,-11,-24,-1,-9,-16,-4,-2,-17,2,0,0,0,-2,-27,-1,0.06,0,0.1199,0,0,0,-0.1599,-0.2299,0,0,0,0,-0.0499
]],
--9 block
[[
-10,-7,3,-14,-1,-2,-15,12,7,-13,12,1,-4,-6,7,3,0,6,5,11,8,10,12,7,0,0,0,-8,-12,4,-1,-22,4,3,-19,-2,2,-28,-2,-10,-23,-1,-7,-15,-4,0,-16,2,0,0,0,-1,-26,-1,0.06,0,0.1199,0,0,0,-0.1599,-0.2299,0,0,0,0,-0.0499/
-11,-8,3,-13,-1,-1,-15,12,7,-13,12,1,-5,-7,7,2,0,6,5,11,8,10,12,7,0,0,0,-9,-13,4,-2,-23,4,2,-19,-2,1,-28,-2,-11,-24,-1,-9,-16,-4,-2,-17,2,0,0,0,-2,-27,-1,0.06,0,0.1199,0,0,0,-0.1599,-0.2299,0,0,0,0,-0.0499
]],
--10 hit blocked
[[
-10,-7,3,-14,-1,-2,-15,12,7,-13,12,1,-4,-6,7,3,0,6,5,11,8,10,12,7,0,0,0,-8,-12,4,-1,-22,4,3,-19,-2,2,-28,-2,-10,-23,-1,-7,-15,-4,0,-16,2,0,0,0,-1,-26,-1,0.06,0,0.1199,0,0,0,-0.1599,-0.2299,0,0,0,0,-0.0499/
-13,-8,3,-13,-1,-1,-15,12,7,-13,12,1,-7,-7,7,1,0,6,5,11,8,10,12,7,0,0,0,-11,-13,4,-3,-23,4,1,-16,-1,4,-24,-4,-12,-24,-1,-13,-16,-4,-6,-15,-4,0,0,0,-6,-29,-1,0.06,0,0.1199,0,0,0,-0.1599,-0.2299,0,0,0,0,-0.0499
]],
--11 hit2
[[
-10,-8,4,-10,3,-2,-15,12,7,-13,12,1,-2,-7,6,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,4,4,-25,5,6,-16,12,12,-14,4,-5,-26,0,-12,-21,1,-6,-14,-4,0,0,0,2,-30,2,0.06,0,0.1199,0,0,0,-0.1499,-0.1399,0,0,0,0,-0.0499/
-10,-8,3,-10,3,-2,-15,12,7,-13,12,1,-2,-7,5,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,5,2,-25,8,6,-16,10,12,-12,1,-7,-26,3,-12,-21,-2,-6,-14,-7,0,0,0,0,-30,2,0.06,0,0.1199,0,0,0,-0.1499,-0.1399,0,0,0,0,-0.0499/
-10,-8,3,-10,2,-1,-15,12,7,-13,12,1,-2,-7,5,4,1,8,5,11,8,10,12,7,0,0,0,-5,-13,5,2,-24,13,6,-16,14,12,-12,6,-7,-25,8,-12,-20,2,-6,-15,-4,0,0,0,0,-29,7,0.06,0,0.1199,0,0,0,-0.1499,-0.1399,0,0,0,0,-0.0499/
-10,-8,4,-10,2,-1,-15,12,7,-13,12,1,-2,-7,6,4,1,8,5,11,8,10,12,7,0,0,0,-5,-13,5,2,-24,10,6,-16,16,12,-11,9,-7,-25,5,-12,-19,2,-7,-16,-5,0,0,0,0,-30,10,0.06,0,0.1199,0,0,0,-0.1499,-0.1399,0,0,0,0,-0.0499
]],
--12 hit3
[[
-10,-8,4,-10,3,-2,-15,12,7,-13,12,1,-2,-7,6,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,4,4,-25,5,6,-16,12,12,-14,4,-5,-26,0,-12,-21,1,-6,-14,-4,0,0,0,2,-30,2,0.06,0,0.1199,0,0,0,-0.1499,-0.1399,0,0,0,0,-0.0499/
-10,-8,4,-10,3,-2,-15,12,7,-13,12,1,-2,-7,6,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,4,3,-26,5,5,-17,12,12,-13,4,-6,-27,0,-11,-20,1,-7,-12,-4,0,0,0,-6,-30,2,0.06,0,0.1199,0,0,0,-0.1499,-0.1399,0,0,0,0,-0.0499/
-8,-8,4,-9,4,-2,-15,12,7,-13,12,1,0,-7,6,6,1,8,5,11,8,10,12,7,0,0,0,-3,-13,4,-2,-25,5,6,-18,10,14,-14,6,-11,-26,0,-8,-21,1,-2,-17,-4,0,0,0,-9,-30,2,0.06,0,0.1199,0,0,0,-0.1499,-0.1399,0,0,0,0,-0.0499/
-10,-8,4,-10,3,-2,-15,12,7,-13,12,1,-2,-7,6,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,4,1,-26,5,5,-17,12,12,-13,4,-8,-27,0,-11,-20,1,-7,-12,-4,0,0,0,-2,-32,2,0.06,0,0.1199,0,0,0,-0.1499,-0.1399,0,0,0,0,-0.0499
]],
--13 punch1_2_idle
[[
-4,-9,1,-6,2,2,-16,8,4,-13,12,1,-5,-7,8,0,1,8,4,11,9,9,12,7,0,0,0,-4,-13,4,-2,-26,10,-10,-20,14,-12,-14,16,8,-25,4,7,-16,6,-4,-12,13,0,0,0,6,-30,7,0.06,0,0.1199,0,0,0,0.1999,0.06,0,0,0,0,-0.0499/
-6,-9,1,-9,2,0,-16,9,5,-13,12,1,-3,-7,8,4,0,8,4,11,8,9,12,7,0,0,0,-4,-13,4,1,-26,10,3,-20,14,11,-14,16,3,-25,0,-5,-21,-5,-5,-15,-2,0,0,0,5,-29,5,0.06,0,0.1199,0,0,0,0.1499,-0.02,0,0,0,0,-0.0499/
-10,-8,4,-10,3,-2,-15,12,7,-13,12,1,-2,-7,6,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,4,4,-25,5,6,-16,12,12,-14,4,-5,-26,0,-12,-21,1,-6,-14,-4,0,0,0,2,-30,2,0.06,0,0.1199,0,0,0,-0.1299,-0.1399,0,0,0,0,-0.0499
]],
--14 punch2_2_idle
[[
-7,-6,0,-10,1,-4,-17,10,5,-13,12,1,-4,-7,8,2,1,6,4,11,10,9,12,7,0,0,0,-4,-13,4,1,-25,3,11,-22,2,10,-20,-10,-9,-24,-2,-14,-16,3,-6,-16,-8,0,0,0,-1,-30,2,0.06,0,0.1199,0,0,0,-0.07,-0.07,0,0,0.1499,0,-0.0499/
-9,-7,2,-9,2,-4,-16,11,6,-13,12,1,-2,-7,7,4,0,7,4,11,9,9,12,7,0,0,0,-5,-13,4,3,-25,3,8,-19,9,12,-16,-3,-7,-24,-2,-12,-19,3,-4,-15,-6,0,0,0,1,-30,1,0.06,0,0.1199,0,0,0,-0.07,-0.07,0,0,0.1499,0,-0.0499/
-10,-8,4,-10,3,-2,-15,12,7,-13,12,1,-2,-7,6,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,4,4,-25,5,6,-16,12,12,-14,4,-5,-26,0,-12,-21,1,-6,-14,-4,0,0,0,2,-30,2,0.06,0,0.1199,0,0,0,-0.1299,-0.1399,0,0,0,0,-0.0499
]],
--15 kick1
[[
-9,-8,3,-10,3,-2,-15,12,7,-13,12,1,-3,-7,7,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,4,4,-25,4,6,-16,11,12,-13,3,-5,-26,-1,-12,-21,1,-6,-14,-5,0,0,0,2,-30,1,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-1,-8,3,-8,1,2,-17,9,4,-13,12,1,4,-7,7,9,0,7,5,11,8,10,12,7,0,0,0,2,-13,4,4,-24,7,-5,-16,11,-5,-7,15,-2,-25,-2,-5,-18,-6,7,-15,3,0,0,0,4,-30,1,0.06,0,0.1199,0,0,0,-0.1199,-0.03,0,0,0,0,-0.0499/
4,-10,1,4,1,0,-6,-2,0,-7,3,-2,8,-9,8,11,1,8,5,11,8,10,12,7,0,0,0,5,-15,6,3,-27,12,2,-19,15,7,-15,16,3,-27,1,6,-19,-3,12,-13,-4,0,0,0,4,-32,6,0.06,0,0.1199,0,0,0,-0.05,-0.0599,0,0,0,0,-0.0499/
7,-10,1,18,-5,0,9,6,0,9,10,-2,10,-9,8,12,2,8,5,11,8,10,12,7,0,0,0,8,-15,6,5,-27,12,10,-20,15,15,-18,11,5,-27,1,6,-18,-3,7,-11,-4,0,0,0,6,-32,6,0.06,0,0.1199,0,0,0,-0.04,0,0,0,0,0,-0.0499/
11,-11,2,25,-19,2,38,-16,0,40,-21,1,13,-10,8,13,2,8,5,11,8,10,12,7,0,0,0,10,-17,6,13,-28,13,17,-24,17,29,-25,10,13,-28,2,4,-22,-1,2,-14,-4,0,0,0,14,-33,7,0.06,0,0.1199,0,0,0,-0.0799,0.05,0,0,0,0,-0.0499/
10,-11,2,25,-21,2,38,-22,0,39,-27,1,12,-10,8,13,2,8,5,11,8,10,12,7,0,0,0,9,-17,6,12,-28,13,16,-23,15,23,-22,10,12,-28,2,2,-21,-1,5,-13,-4,0,0,0,13,-33,7,0.06,0,0.1199,0,0,0,-0.0699,0.04,0,0,0,0,-0.0499/
9,-11,2,23,-7,0,25,6,0,28,4,-2,13,-10,8,11,1,8,5,11,8,10,12,7,0,0,0,7,-16,6,10,-28,12,14,-23,15,21,-21,12,10,-28,1,2,-20,-4,5,-14,-5,0,0,0,11,-33,6,0.06,0,0.1199,0,0,0,-0.0999,-0.0699,0,0,0,0,-0.0499/
4,-9,3,13,-2,0,11,9,0,16,9,-2,9,-8,7,10,0,8,5,11,8,10,12,7,0,0,0,5,-14,6,13,-26,8,13,-21,15,21,-19,15,5,-26,-1,0,-18,-4,4,-12,-5,0,0,0,10,-31,3,0.06,0,0.1199,0,0,0,-0.1199,-0.0699,0,0,0,0,-0.0499/
-2,-8,1,-2,-2,1,-13,6,6,-13,10,1,2,-7,9,5,0,8,5,11,8,10,12,7,0,0,0,1,-13,4,10,-25,4,11,-19,11,14,-14,3,1,-26,-1,-6,-18,-2,0,-11,-8,0,0,0,8,-30,1,0.06,0,0.1199,0,0,0,-0.1099,-0.0599,0,0,0,0,-0.0499/
-7,-6,3,-10,2,-4,-15,12,7,-13,12,1,-1,-5,7,6,1,8,5,11,8,10,12,7,0,0,0,-4,-11,4,4,-23,4,7,-15,11,11,-7,4,-5,-24,-1,-9,-19,1,-9,-10,-5,0,0,0,2,-28,1,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-10,-5,3,-10,2,-3,-15,12,7,-13,12,1,-4,-4,7,2,0,8,5,11,8,10,12,7,0,0,0,-7,-10,4,1,-22,4,1,-14,11,6,-7,4,-8,-23,-1,-12,-18,1,-10,-10,-5,0,0,0,-2,-28,1,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-8,-6,3,-10,2,-3,-15,12,7,-13,12,1,-2,-5,7,2,0,8,5,11,8,10,12,7,0,0,0,-5,-11,4,3,-23,4,3,-15,11,8,-8,4,-6,-24,-1,-10,-19,1,-8,-11,-5,0,0,0,0,-29,1,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499
]],
--16 exit_block
[[
-11,-8,3,-13,-1,-1,-15,12,7,-13,12,1,-5,-7,7,2,0,6,5,11,8,10,12,7,0,0,0,-9,-13,4,-2,-23,4,2,-19,-2,1,-28,-2,-11,-24,-1,-9,-16,-4,-2,-17,2,0,0,0,-2,-27,-1,0.06,0,0.1199,0,0,0,-0.1599,-0.2299,0,0,0,0,-0.0499/
-9,-8,3,-10,3,-2,-15,12,7,-13,12,1,-3,-7,7,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,4,4,-25,4,6,-16,11,12,-14,3,-5,-26,-1,-12,-21,1,-6,-14,-5,0,0,0,2,-30,1,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499
]],
--17 kick2
[[
-9,-8,3,-10,3,-2,-15,12,7,-13,12,1,-3,-7,7,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,4,4,-25,4,6,-16,11,12,-13,3,-5,-26,-1,-12,-21,1,-6,-14,-5,0,0,0,2,-30,1,0.06,0,0.1199,0,0,0,0.4897,-0.0899,0,0,0,0,-0.0499/
-9,-14,3,-10,-4,3,-15,5,7,-13,11,4,-3,-13,7,1,-5,8,3,5,8,9,10,7,0,0,0,-5,-19,4,3,-31,8,0,-22,13,6,-19,5,-2,-30,-2,0,-23,-4,9,-19,2,0,0,0,2,-36,3,0.06,0,0.1199,0,0,0,0,-0.1399,0,0,0,0,-0.0499/
-3,-14,3,3,-5,1,-1,7,0,3,13,-1,-7,-13,9,-6,-4,12,-16,6,8,-15,13,16,0,0,0,-5,-19,4,-2,-31,8,-5,-22,11,4,-20,11,2,-31,-2,0,-24,-5,8,-18,-2,0,0,0,2,-36,3,0.06,0,0.1199,0,0,0,0.11,0.1599,0,0,0,0,-0.0499/
-3,-7,3,5,0,4,0,11,1,5,12,0,-9,-8,9,-10,3,9,-15,12,7,-13,12,14,0,0,0,-5,-13,5,-5,-26,6,-5,-18,12,2,-14,11,4,-25,0,6,-16,-2,12,-12,4,0,0,0,2,-30,4,0.06,0,0.1199,0,0,0,0.08,0.1699,0,0,0,0,-0.0499/
-3,-8,5,3,0,10,0,11,1,5,12,6,-11,-8,3,-16,1,5,-17,12,5,-22,10,9,0,0,0,-7,-13,4,-12,-26,6,-19,-24,2,-27,-21,3,-4,-25,10,-2,-21,16,0,-20,23,0,0,0,-6,-32,10,0.06,0,0.1199,0,0,0,0.3298,0.3798,0,0,0,0,-0.0499/
1,-13,6,-3,-2,5,0,12,0,-2,10,4,-6,-14,-1,-8,-7,-7,4,-2,-13,2,3,-15,0,0,0,-3,-19,4,-11,-31,2,-11,-29,-7,-19,-31,-13,-10,-29,12,-8,-20,15,-20,-19,9,0,0,0,-9,-36,7,0.06,0,0.1199,0,0,0,0.5697,0.3998,0,0,0,0,-0.0499/
-6,-13,9,-3,-3,1,0,12,3,-5,11,2,-1,-14,2,-1,-18,-12,9,-19,-12,8,-19,-18,0,0,0,-6,-19,7,-6,-33,6,-1,-25,5,-11,-26,-1,-14,-26,-2,-20,-17,4,-21,-10,0,0,0,0,-12,-34,1,0.06,0,0.1199,0,0,0,0.7496,0.6996,0,0,0,0,-0.0499/
-2,-17,2,-2,-6,1,-1,8,3,0,12,-2,3,-23,8,17,-27,1,33,-30,3,36,-32,-1,0,0,0,-3,-23,4,-4,-35,2,-1,-26,1,-3,-19,-10,-9,-26,-4,-12,-18,0,-11,-10,-3,0,0,0,-8,-34,-3,0.06,0,0.1199,0,0,0,0.7596,0.8796,0,0,0,0,-0.0499/
-4,-17,2,-4,-5,0,0,6,1,1,11,0,2,-21,7,11,-18,-2,13,-16,13,19,-15,12,0,0,0,-4,-23,4,-5,-33,2,3,-26,10,6,-22,-1,-10,-27,-4,-17,-21,1,-11,-13,-4,0,0,0,-9,-34,-2,0.06,0,0.1199,0,0,0,0.7896,0.8196,0,0,0,0,-0.0499/
-7,-15,1,-10,-5,1,-14,4,3,-14,9,0,-1,-17,7,7,-11,5,11,-3,6,15,-1,8,0,0,0,-6,-20,2,1,-28,3,2,-21,8,5,-20,-1,-8,-27,-3,-13,-21,-1,-9,-14,-8,0,0,0,-3,-33,-3,0.06,0,0.1199,0,0,0,0.8495,0.8595,0,0,0,0,-0.0499/
-10,-11,5,-10,1,1,-15,6,5,-14,9,0,-5,-12,10,1,-4,6,4,5,8,7,10,8,0,0,0,-6,-17,6,2,-25,7,3,-19,7,6,-14,-1,-6,-25,-4,-13,-19,-2,-11,-15,-8,0,0,0,-1,-31,0,0.06,0,0.1199,0,0,0,0.8396,0.7896,0,0,0,0,-0.0499/
-9,-5,3,-10,3,-4,-15,12,7,-13,12,1,-3,-4,7,6,1,8,5,11,8,10,12,7,0,0,0,-5,-10,4,4,-22,4,7,-11,11,12,-7,3,-5,-23,-1,-10,-15,1,-7,-8,-5,0,0,0,2,-27,1,0.06,0,0.1199,0,0,0,0.8296,0.7896,0,0,0,0,-0.0499/
-9,-8,3,-10,3,-2,-15,12,7,-13,12,1,-3,-7,7,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,4,4,-25,4,6,-16,11,12,-14,3,-5,-26,-1,-12,-21,1,-6,-14,-5,0,0,0,2,-30,1,0.06,0,0.1199,0,0,0,0.8396,-0.1399,0,0,0,0,-0.0499
]],
--18 dying
[[
-9,-8,3,-10,3,-2,-15,12,7,-13,12,1,-3,-7,7,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,4,4,-25,4,6,-16,11,12,-14,3,-5,-26,-1,-12,-21,1,-6,-14,-5,0,0,0,2,-30,1,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-9,-8,3,-10,3,0,-19,9,4,-13,12,1,-3,-7,7,3,1,8,5,11,8,10,12,7,0,0,0,-6,-13,4,-3,-25,7,1,-16,11,5,-7,11,-5,-26,0,-9,-17,-3,-7,-8,-9,0,0,0,-4,-31,6,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-8,-6,3,-9,4,0,-17,6,1,-13,12,1,-2,-5,7,5,1,7,5,11,8,10,12,7,0,0,0,-7,-11,4,-2,-23,8,-3,-14,10,-1,-6,13,-4,-24,1,-7,-15,-3,-7,-6,-5,0,0,0,-5,-29,8,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-3,-1,3,-4,10,0,-15,6,1,-13,12,1,3,0,7,12,1,7,5,11,8,10,12,7,0,0,0,-1,-6,4,1,-17,8,2,-8,9,12,-4,9,-1,-18,1,-2,-9,-2,6,-4,-4,0,0,0,-2,-24,5,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-5,-1,3,-4,10,0,-15,4,1,-16,12,1,1,0,7,12,1,6,5,11,8,10,12,7,0,0,0,-2,-6,4,8,-14,8,9,-5,9,19,-1,9,6,-15,1,0,-5,-2,4,4,-4,0,0,0,11,-20,7,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-4,-1,3,-4,10,0,-15,6,1,-13,12,1,2,0,7,12,1,5,5,11,8,10,12,7,0,0,0,0,-6,4,12,-9,8,13,0,9,21,2,4,10,-10,1,5,2,-2,8,12,-4,0,0,0,16,-7,7,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-2,-1,3,-4,10,0,-14,6,1,-14,12,1,4,0,7,13,1,5,5,11,8,10,12,7,0,0,0,2,-6,4,13,-9,8,14,0,9,23,4,7,11,-10,1,5,2,-2,8,12,-4,0,0,0,17,-6,7,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499
]],
--19 dead
[[
-4,-1,3,-4,10,0,-15,6,1,-13,12,1,2,0,7,12,1,5,5,11,8,10,12,7,0,0,0,0,-6,4,12,-9,8,13,0,9,21,2,4,10,-10,1,5,2,-2,8,12,-4,0,0,0,16,-7,7,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-2,-1,3,-4,10,0,-14,6,1,-14,12,1,4,0,7,13,1,5,5,11,8,10,12,7,0,0,0,2,-6,4,13,-9,8,14,0,9,23,4,7,11,-10,1,5,2,-2,8,12,-4,0,0,0,17,-6,7,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499
]],
--20 won_transition
[[
-9,-8,3,-10,3,-2,-15,12,7,-13,12,1,-3,-7,7,5,0,8,5,11,8,10,12,7,0,0,0,-5,-13,4,4,-25,4,6,-16,11,12,-14,3,-5,-26,-1,-12,-21,1,-6,-14,-5,0,0,0,2,-30,1,0.06,0,0.1199,0,0,0,-0.1799,-0.1399,0,0,0,0,-0.0499/
-7,-9,6,-9,0,3,-11,12,7,-11,12,1,-1,-9,7,5,0,5,5,11,8,6,12,2,0,0,0,-4,-15,6,4,-27,4,5,-20,8,8,-12,3,-7,-29,5,-12,-20,8,-11,-11,5,0,0,0,-1,-34,3,0.06,0,0.1199,0,0,0,-0.1799,-0.2498,0,0,0,0,-0.0499/
-5,-10,4,-8,0,3,-8,12,7,-9,12,1,1,-10,5,5,0,5,5,11,8,6,12,2,0,0,0,-2,-16,4,4,-28,4,7,-20,5,8,-12,3,-7,-28,5,-9,-21,8,-11,-11,6,0,0,0,-1,-34,3,0.06,0,0.1199,0,0,0,-0.1799,-0.2498,0,0,0,0,-0.0499
]]
,
--21 won
[[
-5,-10,4,-8,0,3,-8,12,7,-9,12,1,1,-10,5,5,0,5,5,11,8,6,12,2,0,0,0,-2,-16,4,4,-28,4,7,-20,5,8,-12,3,-7,-28,5,-9,-21,8,-11,-11,6,0,0,0,-1,-34,3,0.06,0,0.1199,0,0,0,-0.1799,-0.2498,0,0,0,0,-0.0499/
-3,-9,4,-6,1,3,-8,12,7,-8,12,1,3,-9,5,7,1,5,6,11,8,7,12,2,0,0,0,0,-15,4,5,-27,2,12,-20,5,17,-14,3,-5,-26,7,-9,-20,9,-16,-19,5,0,0,0,1,-33,3,0.06,0,0.1199,0,0,0,-0.3398,-0.2498,0,0,0,0,-0.0499/
-3,-10,5,-6,1,3,-8,12,7,-8,12,1,3,-12,5,5,1,6,6,11,8,7,12,2,0,0,0,0,-17,4,6,-28,6,7,-17,10,12,-11,7,-3,-33,1,-7,-39,-3,-6,-45,-6,0,0,0,3,-35,2,0.06,0,0.1199,0,0,0,-0.2299,-0.2498,0,0,0,0,0.1/
-3,-8,5,-6,1,2,-8,12,7,-8,12,1,3,-10,5,5,1,6,6,11,8,7,12,2,0,0,0,0,-15,4,4,-25,6,7,-17,9,12,-10,7,-5,-28,1,-10,-28,-4,-6,-34,-6,0,0,0,1,-32,3,0.06,0,0.1199,0,0,0,-0.2299,-0.2498,0,0,0,0,0.0101/
-3,-10,5,-6,1,4,-8,12,7,-8,12,1,3,-12,5,5,1,6,6,11,8,7,12,2,0,0,0,0,-17,4,5,-28,6,7,-17,10,12,-11,7,-3,-32,1,-6,-38,-3,-4,-44,-6,0,0,0,3,-35,2,0.06,0,0.1199,0,0,0,-0.2299,-0.2498,0,0,0,0,0/
-3,-8,5,-5,1,3,-8,12,7,-8,12,1,3,-11,5,5,1,6,6,11,8,7,12,2,0,0,0,0,-16,4,4,-26,6,7,-18,10,12,-11,7,-5,-29,1,-7,-35,-3,-6,-40,-6,0,0,0,1,-33,3,0.06,0,0.1199,0,0,0,-0.2299,-0.2498,0,0,0,0,-0.0499/
-3,-8,5,-6,1,3,-8,12,7,-8,12,1,3,-8,5,7,1,6,6,11,8,7,12,2,0,0,0,0,-15,4,6,-26,5,14,-27,8,15,-37,5,-4,-26,1,-10,-26,-2,-5,-32,-5,0,0,0,2,-33,3,0.06,0,0.1199,0,0,0,-0.2299,-0.2498,0,0,0,0,-0.0499/
-4,-8,5,-6,1,3,-8,12,7,-8,12,1,2,-8,5,6,1,6,6,11,8,7,12,2,0,0,0,-1,-15,4,5,-28,8,12,-33,7,15,-44,4,-5,-28,4,-8,-34,0,-9,-42,-3,0,0,0,1,-35,7,0.06,0,0.1199,0,0,0,-0.2299,-0.2498,0,0,0,0,-0.0499/
-3,-8,6,-6,1,3,-8,12,7,-8,12,1,2,-8,4,4,1,5,6,11,8,7,12,2,0,0,0,-1,-15,4,4,-26,3,9,-32,-1,11,-41,-4,-4,-26,9,-7,-31,11,-8,-37,15,0,0,0,1,-33,8,0.06,0,0.1199,0,0,0,-0.2999,-0.3697,0,0,0,0,-0.0899/
-3,-8,6,-7,1,3,-8,12,7,-8,12,1,2,-8,3,4,1,5,6,11,8,7,12,2,0,0,0,-1,-15,4,3,-26,4,8,-32,0,10,-41,-3,-3,-26,10,-6,-31,12,-7,-37,13,0,0,0,1,-33,9,0.06,0,0.1199,0,0,0,-0.2999,-0.3697,0,0,0,0,-0.0899/
-4,-8,5,-7,1,3,-8,12,7,-8,12,1,2,-8,5,5,1,6,6,11,8,7,12,2,0,0,0,-1,-15,4,5,-26,7,12,-33,6,15,-42,3,-5,-26,3,-8,-32,-1,-9,-38,-4,0,0,0,1,-33,7,0.06,0,0.1199,0,0,0,-0.2299,-0.2498,0,0,0,0,0.05/
-3,-8,3,-6,1,3,-8,12,7,-8,12,1,2,-8,7,5,1,6,6,11,8,7,12,2,0,0,0,-1,-15,4,5,-26,10,8,-33,11,9,-42,10,-3,-26,0,-4,-32,-1,-3,-38,1,0,0,0,1,-33,7,0.06,0,0.1199,0,0,0,-0.07,-0.1498,0,0,0,0,0.19/
-3,-8,2,-5,1,3,-8,12,7,-8,12,1,2,-8,7,5,1,6,6,11,8,7,12,2,0,0,0,-1,-15,4,5,-26,10,8,-33,12,8,-42,9,-3,-26,0,-3,-32,-2,-2,-39,1,0,0,0,1,-33,6,0.06,0,0.1199,0,0,0,-0.07,-0.1498,0,0,0,0,0.0301/
-4,-8,5,-7,1,3,-8,12,7,-8,12,1,2,-8,5,5,1,6,6,11,8,7,12,2,0,0,0,-1,-15,4,5,-26,7,12,-33,6,15,-42,3,-5,-26,3,-8,-32,-1,-9,-38,-4,0,0,0,1,-33,7,0.06,0,0.1199,0,0,0,-0.2299,-0.2498,0,0,0,0,-0.0499/
-3,-8,5,-6,1,3,-8,12,7,-8,12,1,3,-8,5,7,1,6,6,11,8,7,12,2,0,0,0,0,-15,4,6,-26,5,14,-27,8,15,-37,5,-4,-26,1,-10,-26,-2,-5,-32,-5,0,0,0,2,-33,3,0.06,0,0.1199,0,0,0,-0.2299,-0.2498,0,0,0,0,-0.0499]]
,
--22 env1
[[
-117,-19,-16,-117,12,-16,-25,-2,4,-25,12,4,-20,-2,4,-20,12,4,-15,-2,4,-15,12,4,-10,-2,4,-10,12,4,-124,-20,130,-30,-20,63,-124,-120,62,-124,12,62,22,-120,72,22,12,72,10,-2,4,10,12,4,15,-2,4,15,12,4,20,-2,4,20,12,4,82,-18,37,82,12,36,140,-100,16,140,12,13,-0.01,0,0,0,0,-0.5297,-0.2598,0.1599,0,-0.1599,0,-1.4592,-1.9888,13,-1,-1,-1,-1,3,4,9,-1,-1,-1,3,6,3,2,2,2,2,37,30,43,2,2,2,35,25,3,2,2,2,2,37,29,43,3,2,2,37,23,49,2,2,2,2,1,30,19,2,2,2,9,20,49,2,2,2,2,1,30,19,2,2,2,11,23/
-117,-19,-16,-117,12,-16,-25,-2,4,-25,12,4,-20,-2,4,-20,12,4,-15,-2,4,-15,12,4,-10,-2,4,-10,12,4,-124,-20,130,-20,-20,84,-124,-120,62,-124,12,62,22,-120,72,22,12,72,10,-2,4,10,12,4,15,-2,4,15,12,4,20,-2,4,20,12,4,82,-18,37,82,12,36,140,-100,16,140,12,13,-0.01,0,0,0,0,-0.5297,-0.2598,0.1599,0,-0.1599,0,-1.4592,-1.9888,13,-1,-1,-1,-1,3,4,9,-1,-1,-1,3,6,3,2,2,2,2,37,30,43,2,2,2,35,25,3,2,2,2,2,37,29,43,3,2,2,37,23,49,2,2,2,2,1,30,19,2,2,2,9,20,49,2,2,2,2,1,30,19,2,2,2,11,23
]],
--23 menu_player
[[
-4,-10,4,-5,0,5,-7,12,6,-8,12,0,0,-10,4,2,0,5,3,11,5,3,12,-1,0,0,0,-2,-16,3,3,-28,4,4,-19,-1,-5,-21,0,-8,-28,5,-8,-19,-1,3,-22,-2,0,0,0,-2,-32,2,0,0,0.1199,0,0,0,-0.1799,-0.2498,0,0,0,0,-0.0299
]],
--24 editor
[[
-5,-10,4,-7,0,4,-8,12,7,-9,12,1,1,-10,5,3,0,6,5,11,8,6,12,2,0,0,0,-2,-16,4,4,-28,3,8,-20,5,9,-12,2,-7,-28,4,-10,-21,8,-12,-11,6,0,0,0,-1,-34,3,0.06,0.03,0.1199,0,0,0,-0.1799,-0.2498,0,0,0,0,-0.0699/
-5,-10,4,-7,0,3,-8,12,7,-9,12,1,1,-10,5,3,0,5,5,11,8,6,12,2,0,0,0,-2,-16,4,4,-28,4,8,-20,5,9,-12,2,-7,-28,5,-10,-21,8,-12,-11,6,0,0,0,-1,-34,3,0.06,0.03,0.1199,0,0,0,-0.1799,-0.2498,0,0,0,0,-0.0699/
-5,-9,4,-7,0,2,-8,12,7,-9,12,1,1,-9,5,3,0,4,5,11,8,6,12,2,0,0,0,-2,-15,4,4,-27,4,8,-20,4,9,-12,0,-7,-27,5,-10,-21,8,-12,-11,6,0,0,0,-1,-33,3,0.06,0.02,0.1199,0,0,0,-0.1799,-0.2498,0,0,0,0,-0.0699/
-5,-9,4,-7,0,2,-8,12,7,-9,12,1,1,-9,5,3,0,4,5,11,8,6,12,2,0,0,0,-2,-15,4,4,-27,4,8,-20,4,9,-12,0,-7,-27,5,-10,-21,8,-12,-11,6,0,0,0,-1,-33,3,0.06,0.02,0.1199,0,0,0,-0.1799,-0.2498,0,0,-0,0,-0.0699

]],--25 env2
[[
-120,15,-53,-120,15,21,-133,3,-53,-133,3,21,-87,-2,4,-87,12,4,-82,-2,4,-82,12,4,-22,5,45,-22,25,45,-135,-105,57,-135,25,57,122,-105,57,122,25,57,-5,-105,57,-5,25,57,129,6,21,129,6,-46,15,-2,4,15,12,4,20,-2,4,20,12,4,25,-2,4,25,12,4,117,15,-48,117,15,21,0,-0.1899,0,0,-0.1799,0,0,0,-0.2299,0,0,0,-1.2593,3,3,-1,-1,-1,5,5,5,3,-1,-1,-1,3,10,10,2,2,6,10,10,10,10,2,2,2,2,10,10,2,2,6,10,10,10,10,2,2,2,2,2,2,2,2,6,10,10,10,2,2,2,2,8,2,2,2,2,6,10,10,10,2,2,2,2,8
]],
--26 env3
[[
-54,13,230,-54,13,70,-54,-17,130,-54,-2,130,-73,-22,119,-35,-22,119,-15,-2,4,-15,12,4,198,15,-49,198,15,82,67,-10,112,67,6,112,-196,12,155,-196,12,29,-196,-13,91,-196,2,92,67,8,173,67,16,48,15,-2,4,15,12,4,20,-2,4,20,12,4,25,-2,4,25,12,4,203,-24,110,203,-10,110,0,0,0,0,0,0,0,0,0,0,0,0,0,7,3,12,-1,-1,2,12,0,8,-1,-1,-1,-1,39,31,2,2,2,22,30,30,35,2,2,2,24,34,25,2,2,2,16,30,21,38,2,2,2,16,15,31,11,2,10,26,10,26,6,2,2,2,34,16,18,11,2,10,19,10,19,21,2,2,2,19/
-54,13,230,-54,13,70,-54,-17,130,-54,-2,130,-73,-22,119,-35,-22,119,-15,-2,4,-15,12,4,198,15,-49,198,15,82,67,-10,112,67,6,112,-196,12,155,-196,12,29,-196,-13,91,-196,2,92,67,8,173,67,16,48,15,-2,4,15,12,4,20,-2,4,20,12,4,25,-2,4,25,12,4,203,-24,110,203,-10,110,0,0,0,0,0,0,0,0,0,0,0,0,0,7,3,8,-1,-1,2,12,0,8,-1,-1,-1,-1,39,31,2,2,2,22,30,30,35,2,2,2,24,34,25,2,2,2,16,30,21,38,2,2,2,16,15,31,11,2,10,26,10,26,6,2,2,2,34,16,18,11,2,10,19,10,19,21,2,2,2,19
]],
--27 ai lvl1
[[
0.96,0,0.5,0.6,0.7,0.8,0,0.1,0.15,0.2,0.25,0.5,0.7,0.6,0.69
]],
--28 ai lvl2
[[
0.94,0,0.6,0.7,0.8,0.95,0,0.07,0.15,0.2,0.25,0.45,0.9,0.53,0.7
]],
--29 ai lvl3
[[
0.92,0,0.8,0.85,0.9,0.95,0,0.05,0.09,0.15,0.2,0.4,0.98,0.52,0.9
]],
--30 elements for env3
[[
37,10,120,5,2,7/
85,10,120,5,2,7/
-35,10,130,5,1,9/
-85,10,130,5,1,9/
-65,10,130,9,2,1/
-174,7,100,1,4,8
]]
}
	for ff=1,#animations do
		animations[ff]=split(animations[ff],"/",true)
		for i=1,#animations[ff] do
		animations[ff][i]=
				split(animations[ff][i],true)
		end
	end
	ai_state,ai_move_x_s,ai_move_y_s,ai_rnd,ai_level,ai_difficulty="idle",0,0,0,1,
 {animations[27][1],animations[28][1],animations[29][1]}
end
-->8
--animation system 
function animate(num,speed,player,loop)
 x,y,z=ppos[player][1],
				   ppos[player][2],
							ppos[player][3]
	if  num  != 7
	and num  != 10
	and num  != 11
	and num  != 12
	then
		if (num == 17
		and frame[player] == 12)
		then
			p_action[player]="idle"
			speed*=10
		end	
		speed*=stamina[player]
	end
	anim_syst(num,speed*stamina[player],player,loop) 
 if player!=3
 then
	 player_skeleton(player)
	else
		env_skeleton(player)
 end
end
function camera_rotation(r1, player)
	local sr1,cr1,cx,cy,points=sin(r1),cos(r1),cam_p[2],cam_p[3]*-2,19
	if player == 3
	then
		points=26
	end
	for i=1,points do
	 if i==19 
	 and player!=3 
	 then 
	 	i=32 
	 end
		ppx,ppy=skel[i][2]-cx,skel[i][3]-cy
		local px1,py1=ppx*cr1-ppy*sr1,ppx*sr1+ppy*cr1
		skel[i][2],skel[i][3]=px1+cx,py1+cy
	end
end
function char_rotation(r,player)
	if player==2 then r+=0.5 end
	local sr1,cr1,cx,cy=sin(r),cos(r),ppos[player][1],ppos[player][3]
	for i=1,19 do
		if i==19 and player!=3 then i=32 end
		ppx,ppy=skel[i][1]-cx,skel[i][3]-cy
		local px1,py1=ppx*cr1-ppy*sr1,ppx*sr1+ppy*cr1
		skel[i][1],skel[i][3]=px1+cx,py1+cy
	end
end
function anim_syst(num,speed,player,loop)
	anim_chosen,p_anim[player]=animations[num],num
 step[player]+=game_speed*speed
 if step[player]>1 then
 	step[player]=0 
 	frame[player]+=1 
 end 	
 if (frame[player]+1)
 >#anim_chosen 
 then
	 nextframe[player]=1
	else
		nextframe[player]=frame[player]+1
	end
 if frame[player] > #anim_chosen
 then
	 frame[player]=1
	 if loop==false
	 and (p_action[player]!="idle" 
	 or 	p_action[player]!="block")
	 then
			p_action[player]="idle"
	 end
	end a={}
 local points = 67
 if player == 3 then points = 156 end
 for i=1,points do
 	if i>91 and i<104 then a[i]=anim_chosen[ frame[player] ][i] else
			a[i]=mix(anim_chosen[frame[player] ][i],anim_chosen[ nextframe[player] ][i],step[player])
		end
	end
end
function rst_anim(p) step[p],frame[p]=0,1end
function player_skeleton(player)
 skel={}
 for i=1,18 do
 	add(skel,
 					{a[i*3-2],
 					 a[i*3-1],
 					 a[i*3]})
 end
 for i=55,67 do
 	add(skel,a[i])
 end
 skel[9],skel[17],qbs={
  (skel[1][1]+skel[5][1])/2,
 	(skel[1][2]+skel[5][2])/2,
	 (skel[1][3]+skel[5][3])/2},{
		(skel[11][1]+skel[14][1])/2,
		(skel[11][2]+skel[14][2])/2,
		(skel[11][3]+skel[14][3])/2},{}
	skel[32]={
			skel[17][1]+1,skel[17][2],
			skel[17][3]}
 translate_pl_and_rot_cam(player)
	local c=8
	if player==2 then c=12 end
	local vars={{skel[1],skel[2],
	1.2,1.2,1.7,1.7,skel[19],c,
	8,0,1},{skel[2],skel[3],
	0.5,0.5,1.2,1.2,skel[20],c,
	6,0,1},{skel[3],skel[4],
	0.5,1,1,1,skel[21],c,
	4,1,0},{skel[5],skel[6],
	1.2,1.2,1.7,1.7,skel[22],c,
	8,0,1},{skel[6],skel[7],
	0.5,0.5,1.2,1.2,skel[23],c,
	6,0,1},{skel[7],skel[8],
	0.5,1,1,1,skel[24],c,
	4,1,0},{skel[17],skel[10],
	1,3,1,4,skel[25],c,
	31,0,1},{skel[10],skel[ 9],
	1,4,1,3,skel[26],c,
	18,0,0},{skel[11],skel[12],
	1,1,1.1,1.1,skel[27],c,
	10,0,1},{skel[12],skel[13],
	0.8,0.8,1,1,skel[28],c,
	7,1,1},{skel[14],skel[15],
	1,1,1.2,1.2,skel[29],c,
	10,0,1},{skel[15],skel[16],
	0.8,0.8,1,1,skel[30],c,
	7,1,1},{skel[18],skel[32],
	1.7,1.7,1.7,1.7,skel[31],c,
	19,0,1}}
 	for nn=1,13do
 		qbs[nn]=vars[nn]
 	end
 qbss[player]=qbs
end
function env_skeleton(player)
 skel={}
 for i=1,26 do
 	add(skel,
 					{a[i*3-2],
 					 a[i*3-1],
 					 a[i*3]})
 end
 for i=79,156 do
 	add(skel,a[i])
 end
 translate_pl_and_rot_cam(player)
	qbs={}
	for i=1,13 do
		qbs[ i]=
	 {skel[i*2-1],
	 	skel[i*2],
	 	skel[52+i],
	 	skel[78+i],
	 	skel[65+i],
	 	skel[91+i],
	 	skel[26+i],
	 	a[91+i],
	 	8,
	 	1,
	 	1}
	end
	qbss[player]=qbs
end
function translate_pl_and_rot_cam(player)
 local points =19
 if player==3
 then
 	points=26
 end
 for i=1,points do
 	if i==19 
 	and player !=3 
 	then 
 		i=32 
 	end
 	for b=1,3 do
 		skel[i][b]+=ppos[player][b]
 	end
 end
	if player!=3
	then
	 char_rotation(char_rot*-1,player)
	end
 camera_rotation(cam_r1,player)
end
-->8
--environment
function draw_env()
	if env==1
	then
		cls(6)
		local y,px=cam_r1*700,point_to_2d({40,10,160})
		rectfill(0,70+y,128,128,5)
		plane_x-=0.2
		if plane_x<-16 then plane_x=228 end
		spr(1,plane_x,y+30)
		sspr(0,16,32,16,75,y+36,32,34)
		sspr(0,16,32,12,50,y+50,32,20)
 	sspr(0,16,32,16,20,y+35,22,35)
		sspr(0,16,64,12,80,y+62,100,10)
		sspr(24,24,16,8,45,y+40,16,8,true)
		sspr(24,8,16,8,45+sin(g_time/30)*10,y+30,16,8,true)
		sspr(8,8,32,8,75+cos(g_time/30)*10,y+50,32,8)
 	sspr(0,32,32,32,px[1]-41,px[2]-45,33,32)
		animate(22,0.1,3,true)
	elseif env==2
	then
		cls(13)
		local y,y2,v=cam_r1*400+cam_p[3]*-0.2,cam_r1*540+cam_p[3]*-0.38,cos(g_time/37)
		rectfill(0,23+y2,128,-1,1)
		rectfill(0,23+y2,128,30+y2,8)
		rectfill(0,30+y2,128,70+y2,16)
		rectfill(0,70+y,128,70+y2,1)
		rectfill(0,70+y,128,128,13)
		fillp(░)
	 rectfill(0,85+y2,128,90+y2,8)
		fillp()
		animate(25,0,3,true)
		metro_x,metro=v*v*v*2000-228,point_to_2d({0,10,200})
		for i=1,10 do
			sspr(40,0,88,32,metro[1]+96*i+metro_x,y+35,88,32)
		end
	elseif env==3
	then
		cls(2)
		local y=cam_r1*700
		sspr(32,32,96,24,16,y+45,96,24)
		rectfill(0,72+y,128,128,1)
		animate(26,1,3,true)
		for n=1,3 do
			local pts,pts2=point_to_2d({130*n-250,25,100}),point_to_2d({130*n-250,25,400})
			for i=1,6 do
				line(pts[1]+i,pts[2],pts2[1], pts2[2],6)
			end
		end
		local yo8,p=y*0.8,point_to_2d({130,25,100})
		rectfill(0,73+yo8,128,73+y,5)
		sspr(32,32,96,24,16,y+72,96,12,false,true)
		fillp(▒)
		rectfill(0,76+yo8,128,73+yo8,6)
		fillp()
		rect(0,76+yo8,128,72+yo8,6)
		rectfill(0,p[2],128,p[2]+1,6)
	end
	if env>0 then
		draw_particles_ground()
		draw_fighter(3)
		if env==3 then
			for bn=1,6 do
				local ev=animations[30][bn]
				rect3d(ev[1],ev[2],ev[3],ev[4],ev[5],ev[6])
			end
		end
	end
end
-->8
--ai
function ai()
	if game_state=="solo"
	then
		if rnd()>ai_difficulty[ai_level][1]
		then
		 ai_rnd=rnd()
		end
		if f_dist>32
		then
			for i=2,6 do
				if ai_rnd>ai_difficulty[ai_level][i] then
					ai_state=ai_vars[i]
				end
			end
		else
			for i=7,10 do
				if ai_rnd>ai_difficulty[ai_level][i] then
					ai_state=ai_vars[i]
				end
			end
			if ai_rnd>ai_difficulty[ai_level][11] then
				if stamina[2]>ai_difficulty[ai_level][15] then
					ai_state="kick"
				end
			end
			if ai_rnd>ai_difficulty[ai_level][12] then
				if stamina[2]>ai_difficulty[ai_level][15] then
					ai_state="punch"
				end
			end
			if ai_rnd>ai_difficulty[ai_level][13] then
				ai_state="idle"
			end
			if p_action[1]=="punch1"
			or p_action[1]=="kick1"
			or p_action[1]=="kick2"
			then
				if ai_rnd>ai_difficulty[ai_level][14] then
					ai_state="block"
				end
			end
		end
	end
end
__gfx__
00000000000000000000000000000000000000000005555555555555555555555555555555555555555555555555555555555555555555555555555555555500
11000000000000080000000000000000000000000555555555555555555555555555555555555555555555555555555555555555555555555555555555555550
21100000fffff8f00000000000000000000000000222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
3311100000fff0000000000000000000000000005555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
44221000000000000000000000000000000000002222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
d5551100000000000000000000000000000000002227272722222227272727272727222222222222222222222222222222222222222727272722222272727222
666d5110000000000000000000000000000000002222757222222275757575757575722222222626262626262626262626262222227575757572222257575722
77776d51000000000000000000000000000000002227575722222257575757575757522222226565656565655565656565656222222757575752222275757222
88884421000000000000000000000000000000002275757222222275757575757575722222265757575756565657575757562222227575757572222257575722
ff99421000000000000000000000000ddd0000002227575722222257575757575757522222227575757575655575757575756222222757575752222275757222
7aa765210000000dffd000000000dfdfdfd0d0002275757222222275757575757575722222265757575757065657575757572222227575757572222257575722
bbbbb3100000dfdffffdff000dfffffdfffdffd02227575722222257575757575757522222227575757575655575757575756222222757575752222275757222
ccccc521000dfdffffdfdfdd0fddffdddddfdddd2275757222222275757575757575722222265757575757565657575757572222227575757572222257575722
ddd521000dddddddddddddfddddddddddddddddd2227575722222257575757575757522222227575757575655575757575756222222757575752222275757222
fee4421000000ddddddddddd0000000ddddddd002275757222222275757575757575722222265757575757565657575757572222227575757572222257575722
fff94210000000000000000000000000000000002227272722222227272727272727222222227575757575655575757575756222222727272722222272727222
000000000ddddd000000000000000000212121212222222222222222222222222222222222265757575757565657575757572222222222222222222222222222
0000000ffddddddd0000000000000000121212122222222222222222222222222222222222257575757575655575757575756222222222222222222222222222
00000ffffdddddddddd0080000000000212121212222222222222222222222222222222222265757575757565657575757575222222222222222222222222222
00000ffffdddddddddd00d0000000000121212125555555555555555555555555555555555557575757575655575757575756555555555555555555555555555
00000ffffdddddddddd00d0000000000212121212222222222222222222222222222222222265757575757565657575757575222222222222222222222222222
00000ffffdddddddddd00d0000000000121212122222222222222222222222222222222222256565656565655565656565656222222222222222222222222222
00000ffffdddddddddd0dddd00000000212121215555555555555555555555555555555555565656565656565656565656565555555555555555555555555555
00000ffffdddddddddd0dddd00000000121212125555555555555555555555555555555555556565656565655565656565656555555555555555555555555555
00000ffffddddddddddddddd00000000000000005555555555555555555555555555555555565656565656565656565656565555555555555555555555555555
00000ffffddddddddddddddd00000000000000005555555555555555555555555555555555556565656565655565656565656555555555555555555555555555
00000ffffddddddddddddddd00000000000000005555555555555555555555555555555555565656565656565656565656565555555555555555555555555555
00000ffffddddddddddddddd00000000000000005555555555555555555555555555555555556565656565655565656565656555555555555555555555555555
00000ffffddddddddddddddd00000000000000005333333333333333333333333333333333565656565656565656565656565533333333333333333333333333
00000ffffddddddddddddddd00000000000000005555555555555555555555555555555555556565656565655565656565656555555555555555555555555555
00000ffffddddddddddddddd00000000000000005333333333333333333333333333333333565656565656565656565656565533333333333333333333333333
00000ffffddddddddddddddd00000000000000005333333333333333333333333333333333556565656565655565656565656533333333333333333333333333
00550005555550000000000000000000000008000000000000000000000000000000000000000000000000000000000000000000005ddd500000080000000000
00555555555550000000000000000000000000005555550000000000000000000000000000000000000000000000000000000000000ded00000000000d000000
00550000000000000000000000000005000000005555000000000000000000000000000008000008000000000000000000000000000f7f0000000d000d055000
00550000000000000000000000000005000000000000000000000000000000000000000000d666d0000000000000000000000000000f7f0000000d000d055000
0055000000000000000000000000005000000000555500000000000000000000000000000005f500000000000000000000000000000ded0000000d000d055000
00550000000000000000000000000050000000000700000000000000000000000000000000057500000000000000000000000000005ddd5000000d000d055000
005500000000000000000000000000500000000000060000000000000000000000000000000575000000000000500000000000000500500500000d0d0d055000
0055000000000000000000000000050000000000070060000000000000800000000000000005f5000000000080550000000080000d50d50d00000d050dd55000
0055000000000000000000000000050000000000000700000000000000505000000000000055d5555500000055555555555550000d05d05d0000060006d55000
00550000000000000000000000005000000000000700700000000000005050000000000000555505dd00000000500000000000000d00d00d0000060606055000
0055000000000000000000000000500000000d0000070000000000000050500000000000005055005d00000000050d00000000000d50d50d0000070706055000
0055000000000000000000000000500000000fff0700700000000000005050000000000000500d05dd00000000500d00000000000d05d05d0000060607055000
0055000000000000000000000005000000000d0d00070000d6d6d6d000d0d0000000000000500d005d00000000050d5000000000050050050000070706050000
0055500000000000000000000005000000000d0d07007000f00600f0005050000000000000500d05dd0000000050055555555555555555550000060607050000
005550000000000000000000005000000000000000070000e07677e000d0d0000000000000500d005d0000000005055707070707070700050000070606000000
0055050000000000000000000500000000000d0007007000d00000d0005050050000000000577d05dd0000000050055070707070707000050005005550050000
0055050000000000000000000500000000000d00000700005077675000d0d00500000000000000005d0000000005055555555555555500050005ddddddddd000
0055005000000000000000005000000000000d00000070005000005000505005055555ddddff0605dd0000000050050000000000000050050005000000000500
0055005000000000550000050000000000000d00000700005076775000d0d00500000000000f0d005d00000000050d0535535353555050050005000000000020
0055000500000005500000500000000000000d0033006000d00000d00050500d00000000000d0d05dd00000000500d00000000000000d0050005555555555520
0055000500000055500005000000000000000d0000060000fddd66f000d0d00d00000000000d05005000000000050d05355353535550d00d0005500000000050
0055000055000555000550000000000000000d0033006000e00000e00050500500000000000505000000000000500e00000000000000e00d0005505555555050
00550000005500500050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00550000000555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0055000000000000000000000000000000000b000000010000000500000000000000030000000b0000000b000000010000000500000000000000030000000b00
0055000000000000000000000000000000000bb000000b10000001100000030000000b3000000bb000000bb000000b10000001100000030000000b3000000bb0
0055000000000000000000000000000000000bbb00000bbb0000033300000b3300000bb300000bbb00000bbb00000bbb0000033300000b3300000bb300000bbb
0055000000000000000000000000000000000bb300000b330000033300000bbb00000bbb00000bbb00000bb300000b330000033300000bbb00000bbb00000bbb
0055000000000000000000000000000000000b30000003000000050000000b1000000bb000000bb000000b30000003000000050000000b1000000bb000000bb0
005500000000000000000000000000000000030000000000000000000000050000000b0000000b000000030000000000000000000000050000000b0000000b00
00550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000313131133313311111331133133313331333131133313130000000000000000000000000000000000000000
00033330000000000000000000000000000000000313131131313531113551353133313131313131131313130000000000000000000000000000000000000000
000abbb3333333300000000000000000000000000313131133313131113111313135313331331131133313130000000000000000000000033333333333333300
000cbbbbbbbbbbb300000000000000000000000005351331353133311153313351313135313531331353153300000000000000000000033bbbbbbbbbbbbbb300
00033bbbbbbbbbbb330000000000000000000000015115515151555111155155115151515151515515151155000000000000000000003bbbbbbbbbbbaaa33300
00013c3abbbbbbbbbb300000000003333333133331000000000000000000000000000000000000000000000000333333000000000033bbbbbbbbbaaac333cc00
0000133cabbbbbbbbb30000000000abbbbbb0bbbb3333333333333333330333333333300000133333333330000bbbbbb3000000033bbbbbbbbaaac333c313200
0000011ccabbbbbbbbb30000000003bbbbbb0bbbbbbbbb3bbbbbbbbbbb33bbbbbbbbbb300133bbbbbbbbbb3300bbbbbbb3000003bbbbbbbbba3333c313122000
000000013cbbbbbbbbbb0000000003bbbbbb0bbbbbbbbb3bbbbbbbbbbb3bbbbbbbbbbbb013bbbbbbbbbbbbb305abbbbbbb30033bbbbbbbbaa33c333122000000
0000000013abbbbbbbbb0000000001abbbbb0aaabbbbba3baabbbbbaab3bbbbbbbbbbbb33bbbbbbbbbbbbbb3013abbbbbbb33bbbbbbbbba33333102200000000
0000000001cbbbbbbbbb30000000003bbbbb0333bbbbb33333bbbbb3333bbbbaaaabbbb33bbbbbaaaabbbbbb3133abbbbbbbbbbbbbbbaa333310000000000000
00000000003bbbbbbbbbb3333333301bbbbb033cbbbb333c33bbbbbcc3bbbbb3333bbbb33bbbb33333bbbbbbbb3c3abbbbbbbbbbbbaa33c31000000000000000
00000000001bbbbbbbbbbbbbbbbbbbbbbbbb0133bbbb336333bbbbb333bbbbb3333bbbb3bbbbb33333bbbbbbbb23c3bbbbbbbbbbaa33c3310000000000000000
00000000000bbbbbbbbbbbbbbbbbbbbbbbbb0000bbbb3d2057bbbbb526bbbbbb77bbbbbbbbbbb376333bbbbbbb0dc3bbbbbbbbbb33c333000000000000000000
00000000000bbbbbbbbbbbbbbbbbbbbbbbbb0000bbbb3d22ddbbbbbdd7bbbbbbbbbbbbbbbbbbb00d253bbbbbbb0dd6bbbbbbbbbb3c3300000000000000000000
00000000000bbbbbbbbbaaaaaaaaaaabbbbb0000bbbb000000bbbbb0003bbbbbbbbbbbbbbbbbb000003bbbbbbb00d6bbbbbbbbbbab3000000000000000000000
00000000000bbbbbbbbbc3333333333bbbbb0000bbbb000000bbbbb0003bbbbaaaabbbbbbbbbb000003bbbbbba000bbbbbbbbbbbbbb300000000000000000000
00000000000bbbbbbbbb33333333333bbbbb0003bbbb500000bbbbb0003bbbb3333bbbbb3bbbb100003bbbbba300bbbbbbbbbbbbbbbb30000000000000000000
00000000003bbbbbbbbb3333333333bbbbbb100bbbbb500000bbbbb0003bbbb3333bbbbb7abbb331133bbbbb330bbbbbbbbaaabbbbbbb3000000000000000000
0000000003bbbbbbbbbb1222222222bbbbbb53bbbbbbb50000bbbbb0003bbbb7777bbbb33bbbbbbbbbbbbbbb33bbbbbbbba33abbbbbbbbb33000000000000000
000000003bbbbbbbbbba5500000000bbbbba53bbbbbbb30000bbbbb0003bbbbbbbbbbbbb3bbbbbbbbbbbbbb311bbbbbbba3333abbbbbbbbbbb30000000000000
00000003bbbbbbbbbba3000000000bbbbbba03bbbbbbb30000bbbbb2005bbbbbbbbbbbac7cbaabbbbbbbbbb305bbbbbba33233baabbbbbbbbbb3330000000000
0000000bbbbbbbbbbb33000000000bbbbba305aaaaaaa32000baaab500333a7777a7a63327c3baaaaaaaaa3105bbbbbb331057c33aabbbbbbbbbbb3300000000
0000033bbbbbbbbbba31f20000000baaaab323333333300000b333300213333333333331063c33333333333005aaaaab310007dc333aaabbbbbbbbbb33000000
00033bbbbbbbbbaaa3327000000003333331633cccc33100003ccc1002133ccccccc33100f6dcccccccc33100533333310000266cc3333abbbbbbbbbbb333000
033bbbbbbbbbba3333165000000003ccc33561133333356000133c5000013367777c31d00df666cc333331000133cc330000006666ccc33aabbbbbbbbbbbb333
3bbbbbbaaaaaa33c315d0000000001333366d000022df7d000000650002d025666622dd002667665222000000d73333100000000dd6733c33aaaaabbbbbbbbbb
3bbbaaa3333333133df50000000000002577200555525d500055557200055d5666ddd0000222d7555555500005f552200000000000d7257c333333aaaaaaabb3
53333331cccc3165276000000000005555d2000000000000000000000000000000000000000222000000000000255555000000000002057c3cccc33333333aaa
33ccc3313333367d05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006d663333c3cccc3333
63c3333d22225760000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d7ddddd333333c3c
6d22255d555505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000d6d555dd6
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0bbbbbbbbbbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000
b66666666666666bbdddddddddddddb0bddddddddddddddb00000000000000000000000000000000000000000000000000000000000000000000000000000000
b66666666666666bb8888888888888b0bddddddddddddddb00000000000000000000000000000000000000000000000000000000000000000000000000000000
b66666666666666bb2222222222222b0bddddddddddddddb00000000000000000000000000000000000000000000000000000000000000000000000000000000
b55555555555555bb2222222222222b0b55555555555555b00000000000000000000000000000000000000000000000000000000000000000000000000000000
b55555555555555bb2222222222222b0b55555555555555b00000000000000000000000000000000000000000000000000000000000000000000000000000000
b55555555555555bb2222222222222b0b55555555555555b00000000000000000000000000000000000000000000000000000000000000000000000000000000
b55555555555555bb2222222222222b0b55555555555555b00000000000000000000000000000000000000000000000000000000000000000000000000000000
b55555555555555bb2222222222222b0b55555555555555b00000000000000000000000000000000000000000000000000000000000000000000000000000000
b55555555555555bb1111111111111b0b55555555555555b00000000000000000000000000000000000000000000000000000000000000000000000000000000
b55555555555555bbdddddddddddddb0b55555555555555b00000000000000000000000000000000000000000000000000000000000000000000000000000000
b55555555555555bbdddddddddddddb0b55555555555555b00000000000000000000000000000000000000000000000000000000000000000000000000000000
b55555555555555bbdddddddddddddb0b55555555555555b00000000000000000000000000000000000000000000000000000000000000000000000000000000
b55555555555555bbdddddddddddddb0b55555555555555b00000000000000000000000000000000000000000000000000000000000000000000000000000000
b55555555555555bbdddddddddddddb0b55555555555555b00000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0bbbbbbbbbbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
iihhhhhhhiiiiiihhiiiiiiihhhhhhhhiiiiiiiiihhhhhhhhhhhhhhhhhhhiiiiiiiiiihhhhhhhhhhhhhiiiihhhhhhhhhiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhh
iihhhhhhhiiiiiiihhhhiiiihhhhhhhhiiiiiiiihhhhhhhhhhiiihhhhhhiiiiiiiiiihhhhhhhhhhhhhiiiiiiihhhhhhiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhii
iihhhhhhhiiiiiiihhhhhhhihhhhhhhiiiiiiiihhhhhhhhhhiiiiiiihhhiiiiiiiiiihhhhhhhhhhhhiiiiiiiiiiihhiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhiii
iihhhhhhhiiiiiiihhhhhhhiihhhhhhiiiiiiiihhhhhhhhhiiiiiiiiihhhiiiiiiiihhhhhhhhhhhhiiiiiiiiiiiihhhiiiiiiiiiiihhhhhhhhhhhhhhhhhiiiii
iihhhhhhhiiiiiiihhhhhhhiiiiiihhiiiiiiiihhhhhhhhhiiiiiiiiihhhhhiiiiihhhhhhhhhhhiiiiiiiiiiiihhhhhhhiiiiiiihhhhhhhhhhhhhhhhhiiiiiii
hhhhhhhhhiiiiiihhhhhhhhiiiiiiihhhiiiiihhhjhjhjhhjjjhjjhhhhhjjhhjjhjjjhjjjhjjjhjhhjjjhjhjihhhhhhhhhhhiiihhhhhhhhhhhhhhhhiiiiiiiii
hhijjjjhhiiiiiihhhhhhhiiiiiiiihhhhhhhihhhjhjhjhhjhjhjljhhhjllhjljhjjjhjhjhjhjhjhhjhjhjhjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiii
hhiqrrrjjjjjjjjhhhhhhhiiiiiiihhhhhhhhiihhjhjhjhhjjjhjhjhhhjhhhjhjhjljhjjjhjjhhjhhjjjhjhjhhhhhhhhhhhhiiiihhhhhhhjjjjjjjjjjjjjjjii
hhisrrrrrrrrrrrjhhhhhhiiiiiiihhhhhhhhiiiiljlhjjhjljhjjjhhhljjhjjlhjhjhjljhjljhjjhjljhljjhhhhhhhhhhhiiiiiiihhhjjrrrrrrrrrrrrrrjii
hhijjrrrrrrrrrrrjjhhhiiiiiiihhhhhhhhiiiiihlhhllhlhlhlllhhhhllhllhhlhlhlhlhlhlhllhlhlhhllhhhhhhhhhiiiiiiiiiiijrrrrrrrrrrrqqqjjjii
hhihjsjqrrrrrrrrrrjiihiiiiiihjjjjjjjhjjjjhihhhhhhhhihhhhhhhhhiiiiiiiiiihhhhhhhhhiihhhhhhhhjjjjjjiiiiiiiiiijjrrrrrrrrrqqqsjjjssih
hhiihjjsqrrrrrrrrrjiihhhhhihhqrrrrrrirrrrjjjjjjjjjjjjjjjjjjhjjjjjjjjjjhhhhhhjjjjjjjjjjhhhhrrrrrrjiiiiiiijjrrrrrrrrqqqsjjjsjhjihh
iihhhhhssqrrrrrrrrrjhhhhhhhiijrrrrrrirrrrrrrrrjrrrrrrrrrrrjjrrrrrrrrrrjhhhjjrrrrrrrrrrjjhhrrrrrrrjiiiiijrrrrrrrrrqjjjjsjhjhiihhh
iihhhhhhjsrrrrrrrrrrhhhhhhhiijrrrrrrirrrrrrrrrjrrrrrrrrrrrjrrrrrrrrrrrrhhjrrrrrrrrrrrrrjhlqrrrrrrrjiijjrrrrrrrrqqjjsjjjhiihhhhhh
iihhhhhhhjqrrrrrrrrrhhhhhhiiihqrrrrrhqqqrrrrrqjrqqrrrrrqqrjrrrrrrrrrrrrjjrrrrrrrrrrrrrrjhhjqrrrrrrrjjrrrrrrrrrqjjjjjhhiiihhhhhhh
iihhhhhiihsrrrrrrrrrjhhhhhiiiijrrrrrhjjjrrrrrjjjjjrrrrrjjjjrrrrqqqqrrrrjjrrrrrqqqqrrrrrrjhjjqrrrrrrrrrrrrrrrqqjjjjhhhiiiiiihhhhh
hhhhhhhiiijrrrrrrrrrrjjjjjjjjihrrrrrhjjsrrrrjjjsjjrrrrrssjrrrrrjjjjrrrrjjrrrrjjjjjrrrrrrrrjsjqrrrrrrrrrrrrqqjjsjhhiiiiiiiiiiiihh
hhiiihhhiihrrrrrrrrrrrrrrrrrrrrrrrrrhhjjrrrrjjmjjjrrrrrjjjrrrrrjjjjrrrrjrrrrrjjjjjrrrrrrrrijsjrrrrrrrrrrqqjjsjjhiiiiiiiiiiiiiiii
hhiiiiihhhhrrrrrrrrrrrrrrrrrrrrrrrrrhiiirrrrjtihlnrrrrrlimrrrrrrnnrrrrrrrrrrrjnmjjjrrrrrrrhtsjrrrrrrrrrrjjsjjjiiiiiiiiiiiiiiihhh
hhiiiiihhhhrrrrrrrrrrrrrrrrrrrrrrrrrhhiirrrrjtiittrrrrrttnrrrrrrrrrrrrrrrrrrrhhtiljrrrrrrrhttmrrrrrrrrrrjsjjiiiiiiiiiiiiiihhhhhh
iihhhiihhhhrrrrrrrrrqqqqqqqqqqqrrrrrhhhhrrrrhhhhhhrrrrriihjrrrrrrrrrrrrrrrrrriiiiijrrrrrrriitmrrrrrrrrrrqrjhhiiiiiiiiihhhhhhhhhh
iihhhhhihhhrrrrrrrrrsjjjjjjjjjjrrrrrhhhhrrrrhhhhhirrrrrihhjrrrrqqqqrrrrrrrrrriiiiijrrrrrrqiiirrrrrrrrrrrrrrjhhhhiihhhhhhhhhhhhhh
hhhhhhiiiiirrrrrrrrrjjjjjjjjjjjrrrrrhhhjrrrrliihhhrrrrrhhhjrrrrjjjjrrrrrjrrrrhiiiijrrrrrqjhhrrrrrrrrrrrrrrrrjhhhhihhhhhhhhhhhhhh
hhiihhhhhijrrrrrrrrrjjjjjjjjjjrrrrrrhhhrrrrrlhhhhhrrrrrhhhjrrrrjjjjrrrrrnqrrrjjhhjjrrrrrjjhrrrrrrrrqqqrrrrrrrjiiiiiihhhhhhhhhhhh
hhiiiihhhjrrrrrrrrrrhiiiiiiiiirrrrrrljrrrrrrrlhhhhrrrrriiijrrrrnnnnrrrrjjrrrrrrrrrrrrrrrjjrrrrrrrrqjjqrrrrrrrrrjjiiiiiihhhhhhiii
iihhhhhhjrrrrrrrrrrqllhhhiiiiirrrrrqljrrrrrrrjihhhrrrrrihhjrrrrrrrrrrrrrjrrrrrrrrrrrrrrjhhrrrrrrrqjjjjqrrrrrrrrrrrjiihhhhhhhiiii
hihhhhijrrrrrrrrrrqjiiiihhhhhrrrrrrqijrrrrrrrjhhhhrrrrrihhlrrrrrrrrrrrqsnsrqqrrrrrrrrrrjilrrrrrrqjjijjrqqrrrrrrrrrrjjjhhhhhhhhhi
hhiihhhrrrrrrrrrrrjjhhihhhhhirrrrrqjilqqqqqqqjihhhrqqqrlihjjjqnnnnqnqmjjinsjrqqqqqqqqqjhhlrrrrrrjjhhlnsjjqqrrrrrrrrrrrjjhhhhhhhh
hhhhhjjrrrrrrrrrrqjh7iiiihhhhrqqqqrjijjjjjjjjiiiihrjjjjihihjjjjjjjjjjjjhhmjsjjjjjjjjjjjhilqqqqqrjhhhhntsjjjqqqrrrrrrrrrrjjhiiiii
hhhjjrrrrrrrrrqqqjjinhhhhhhhhjjjjjjhmjjssssjjhhhhhjssshhhihjjsssssssjjhhi7mtssssssssjjhiiljjjjjjhhiiiimmssjjjjqrrrrrrrrrrrjjjiii
hjjrrrrrrrrrrqjjjjhmlhhhhhihhjsssjjlmhhjjjjjjlmiihhjjslihhhhjjmnnnnsjhthht7mmmssjjjjjhhihhjjssjjhhhhhhmmmmsssjjqqrrrrrrrrrrrrjjj
jrrrrrrqqqqqqjjsjhlthhhhhhhihhjjjjmmthhhhiit7ntihhhhhmliioothilmmmmiitthiimmnmmliiiiiiiiitnjjjjhhhhhhiiittmnjjsjjqqqqqrrrrrrrrrr
jrrrqqqjjjjjjjhjjt7lhhhhhhhhhhhhilnnihhlllliltlhihllllooooolltlmmmttthhhhiiitnlllllllihhhl7lliihhhiiiihhhhtnilnsjjjjjjqqqqqqqrrj
ljjjjjjhssssjhmlinmhhhhhhhhhhhlllltihhhhhhhhhhhhhihhoooooogkhhhhihhhhhhhhihiiihhhhhihhhhhhilllllhhhhhhhhhhhihlnsjssssjjjjjjjjqqq
jjsssjjhjjjjjmnthlhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhoooooogkghhhhhhhrrrrrihhhhhhhhhihhhhhhhhhhhhhihhhhhhhhhhhhhmtmmjjjjsjssssjjjj
mjsjjjjtiiiilnmhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhoooooogkgkghhhhhhrrrrrrhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhtntttttjjjjjjsjs
mtiiilltllllhlhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhooooookgkgkhhhhhrrrrrhrrhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhihhhhhtmtlllttm
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhooooookgkgkhhhhrrrrrrrrhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhoooooogkgkghhhhrrrrrrrhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhoooooogkgkghhrrrrrrrrhhhhhhhhhhhhhhhihhhhhhhhhhhihhhhhhhhhhhhhhhhhhhhhhhhihh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhoooohooooookgkgkggrrrrrrrrhhhh77hhhhihhhhhhhhhhhhihhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhihhhhhhhhhhhhhhhhhhihhhooookhooooookgoooookjjrrrjj77777hhhhhhhhhhhhihhhhhhhhhhhhhhhhhhhhhhhhhhhhhiihhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhihhhhhhhhhihhhhhhhhooohhhhoooooogkoooookkjjrrjj77777hhhhhhhihhhhhhhhhhhhhhihhhhhhhhhhhhhhhhihhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhooohhhhhoooooogoooookkjjjjjj7777ghiiiihhhhhhhhhhhiiiiiihhhhhhhhhhhiiiihhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhihhhhhhhhhhhhhihhhhhhooohhhhhoooooohooookkkjjjjjj7777hhhihhhhhhhhhhhhhhhihhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhiihhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhooohhhhhhhhhhhoooookkkjjjjjjj777ghhhhhhhhhhhhiiihhhhhhhhhhhhhhiiiiihhhhhhhhhhhhhhi
hhhhhhhhhhhhhhhhihhhhhhhhhhhhhhhhhhhhhhhiiiiioooohhhhhhhhhhhoooookkjjjjjjjh7777hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhiiiiiihhhhhhhhhhhiiihhhhhhhhhhhhhhhhoooohhhhhhhhhhhoooookkjjjjjjjh7777hhhhhhiiiiiiihhhhhhhhhiiiiiiiiiiiiihhhhhhhhiiiiii
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiihhhhoookkhhhhhhhhhhoooookkjjjjjjjh7777ghhhhhhhhhhhhhhhhhhhhhhhhhihhhhhhhhhhhhhhhhhhhhii
iiiiiiiihhhhhhhhhhiiihhhhhhhhhhhhhhhhhhhhhhhooookkhhhhhhhhhhooookkkjjjjjjjgh777hiiiiiiiiiihhhhhhhhhhhhiiiiihhhhhhhhhhhhhhhhhhhih
hhhhhhhhhhhhiiiiihhhhhhhhhhiiiiiiiihhhhhhhhhooookkhhhhhhhhhhooookkkjjjjjjj77777ghiiihhhhhhhhhhhhhiiiiiiiiiiiiihhhhhhhiiiiiiiiiii
ihhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiioookkkhhhhhhhhhhooookkjjjjjjjjg7777hhihhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiii
hhhiiiiiiiiiiihhhhhhhhhhiihhhhhhhhhhhhhhhhhooookkhhhhhhhhhhoooookkjjjjjjjj777777iiiihhhhhhhhhhhhhhhiiihhhhhhhhhhhhhhhhhhhhhihhhh
hhhhhhhhhhhhhhhhhiiiiiiiiiiihhhhhhhhhiiiiihooookk7hhhhhhhhhoooookkjjjjjjjjii7777iihhhhhhhhhiiiiiiiiiiiiiiihhhhhhhhhhhhiiiiiiiiih
hiiihhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiioook77777hhkkkggohoookkjjjjjjjhhii777hhhhhhhhhhhhhhhiiiiiiiihhhhhhhhhhhiiiiiiiiiiiiii
iiiiihhhhhhhhhhhiihhhhhhhhhhhhhhhiihhhhhhhhoook7777777kkgggooookkkjjjjjjjiiiigghhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiihh
hhhhhhhiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhokkkki77777777hggooookkjjjjjjjjiiiiiiiihhhhhhhhhhhhiiiiiihhhhhhhhhhhhhhhhhhhhhihhhhhhh
hhhhhhhhhiiiiiihhhhhhhhiiiiiiiiiiiihhhhhhhkkkkkkii7777777ghooookkjjjjjjjjjiiihhhhhhhhhiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhiiiiihhhhhh
hhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiihhhhhkkkkkkkkiii777777oooookkrrrrrrrjghhhhhhhhhhhhhhiiiiiiiiiiiiiiihhhhhhiiiiiiiiiiiiiiiiihh
hhhiiiiiiihhhhhhhhhhhhhhhiihhhhhhhhhhhhhiikkkkkkkkkiii7777o7oookkrrrrrrrgjhhhhhhhhhhhhhhhhhhiiihhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiii
iiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhikkkkiiiihiiii77ooookkkrrrrrrrjghhhhhhhhhhhhhhhhhhihhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiih
iiiiiiiihhhhhhhiiiiiiiiiiiihhhhhhhhhhhhhhhhihhhhhhhhhiiiiiooookkrrrrrrrrgjiihhhhhhhhhiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhiihhhhhhhhh
hhhhhhhhhhhhhhhiiiiiiiiiiiiihhhhhhhhhhhhhiiihhhhhhhhhhhiiigoookkrrrrrrrrjghhhhhhhiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhihhhhhhhhh
hhhhhhhhhhhhhhhhiiiiiiiiiihhhhhhiiiiiiiiiiiiiihhhhhhhhhhiiiggggkrrrrrrrrgjhhhhhhhhhiiiiiiiiiiiiiiiiiihhhhhhhhhiiiiiiiiiiiihhhhhh
ihhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiihhhhnnnnniighggrrrrrrrrrjghhhhhhhhhhhiiiiiiiiiiiiihhhhhhhiiiiiiiiiiiiiiiiiiiihhh
iihhhhhhhhhhhhhiihhhhhhhhhhhhhhhhhiiiiiiiiiiiiihhhhhnnnnnnnggtgrrrrgrrrrgjhhhhhhhhhhhhhhiihhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiii
hhhhhhhiiiiiiiiiiihhhhhhhhhhhhhhhhhhiiihhhhhhhhhhhhhnnnnnnnntgtirrrrrrrrjjhhhhhhhhhhhhhhihhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiii
hhhhhiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhnnnnnnnngtgrrrjrrrrrjjhhhhhhhiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhiiiiiiiihhhhhh
hhhhhhiiiiiiiiiiiiiiihhhhhhhhhiiiiiiihhhhhhhhhhhhhhhnnnnnnnnngtgrrjrrrrrjjhiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhihhhhhhhhhhh
hhhhhhhiiiiiiiiihhhhhhhiiiiiiiiiiiiiiiihhhhhhhhhhhhhnnnnnnnnntgtrrjrrrrrjjhhhiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhiiiihhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiihhhhhhhhhhhnnnnnnnnngtgrrjrrrrrjjhhhhhiiiiiiiiiiiiiiiiiiihhhhhhhhhiiiiiiiiiiiiihhhhhhhh
hhhhhhiihhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiihhhhhhhhhhnnnnnnnnntgtgjjrrrrrjhhhhhhhhhiiiiiiiiiiiiiihhhhhhiiiiiiiiiiiiiiiiiiiiihhhhh
iiiiiiiiihhhhhhhhhhhhhhhhhhiiiiiiiiiiiiihhhhhiiiiiiimnnnnnnnnntgtjjhrrrrjhhhhhhhhhhiiiiiihhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiihh
iiiiiiiiiihhhhhhhhhhhhhhhhhhiiiihhhhhhhhhhhhhhhiiiiimmmnnggnnngtrjjhrrrrjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiii
iiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiimmmtnngggtgtjhhrrrrjhhhhhhhhiiiiihhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiii
iiiiiiiiiiiiihhhhhhhhhhiiiiiiihhhhhhhhhhhhhhhhhhhhiiimmmgtnnnngtgjihrrrrjhiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiihhh
iiiiiiiiiiihhhhhiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhiimmmtgnnnntgtghhrrrrjiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhiiiihhhhhhhhh
iiihhhhhhhhhhhhiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhmmmgtnnnnntghhhrrrrjiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhihhhhhhhhhhhh
hhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhmmmmgtnnnngthhhrrrgjhiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhiiiiiihhhhhhhhhhh
hhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiihhhhhhhhhhhhiiiiiimmmmtgnnnntgthhrrrjghhhiiiiiiiiiiiiiiiiiiiiihhhhhhhhiiiiiiiiiiiiiiihhhhhhhh
ihhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiihhhhhiiiiiiiiiiiiimmmgtnnnngtghhrrrgjhhhhhiiiiiiiiiiiiiiiiihhhhhiiiiiiiiiiiiiiiiiiiiiihhhhhh
iihhhhhhhhhhhhhhhhhhiiiiiiiiiihhhhhhhhhiiiiiiiiiiiiiiimmmtgnnnnngtgghrrjghhhhhhhiiiiiiiiihhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiihhh
iihhhhhhhhhhhhhhhhhhhiihhhhhhhhhhhhhhhhhiiiiiiiiiiiiiimmmgthnnnntggghrrgjhhhhhhhhhihhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiiih
iiihhhhhhhhhhhhhhhhhhihhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiikmmtginnnngtghhrrjghhhhhhhhihhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiii
iiiihhhhhhhhhhiiiiiiiiihhhhhhhhhhhhhhhhhhhhiiiiiiiiiiikkkgkinnnntgthhrrrjhhiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiii
iiihhhhhiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhiiiiiiiiiikkkkiiinnnntghhrrrgigghiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiii
hhhhhhhiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhiiiiiiiiikkkgihhnnnngkiirrrjgghhiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiih
hhhhhhhhiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhiiiiiihkkkkhhhoognkghiirrghhhiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiihhhhhh
hhhhhhhhiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhkkghhhhooogkhhhrrjhhiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhiiiihhhhhhkgkhhhhoookghhhrrgiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhiihhhhhhhhhhh
hhhhhhhhhhhiiiiiiiiiiiiiiiiiiihhhhhhhhhiiiiiiiiiiihhhhhkkhhhhhooogkhhhhrjiiiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhiiiiiiiiiihhhhhhhhh
hhhhhhhhhhhhiiiiiiiiiiiiiiiiihhhhiiiiiiiiiiiiiiiiiiihhhkghhhhhoookghhhhhhhiiiiiiiiiiiiiiiiiiiiiiihhhhhhhiiiiiiiiiiiiiiiiihhhhhhh
hhhhhhhhhhhhhiiiiiiiiiihhhhhhhhhhiiiiiiiiiiiiiiiiiiiihgkkhhhhhhoogkhhhhhjhhhiiiiiiiiiiiiiiiiiiihhhhiiiiiiiiiiiiiiiiiiiiiiiiihhhh
hhhhhhhhhhhhhhiiihhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiigggkgghhhhjoooghhhhhhhjhhhiiiiiiiiiiihhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiiiiihh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiigggigghhhhhhoookhhhhhjhhhhhhiiiiihhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiiiii
hhhhhhhhhiiiiiihhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiigggigiiihhhhjoooghhhjhhhjhhhhhihhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiii
hhhiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiggiggiiiiihhhhhookhhhhhjhhhhiiiihhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiii
iiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiigggiiiiiiiihhrhooghhhjiiiriiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiii
iiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiihiiiiiiiihhhookijiiijiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiii
iiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiioiihhhhhrhhhgiiijiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiii
hiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhiiiiiiiihohhhhhhhhhhhhgiiiiiiriiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiii
hiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhiiihhhhhhhhohhhhhhhhhggriiiriiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiii
hhhiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhhohhhohhhhhhgghhhiiiiriiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiihhh
hhhiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhiiiiiiihhhhhhhhohhhhhhhhghhrhhiriiiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhihhhhhhhh
hhhhhiiiiiiiiiiiiiiiiiiiihhhhhhhhiiiiiiiiiiiiihhhhhhohhhohhhghghrhhhrhhiriiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhiihhhhhhh
hhhhhiiiiiiiiiiiiiiiiiiihhhhiiiiiiiiiiiiiiiiiiiihhhhhhohhhhghgghhhrhhhrhiiiiiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhiiiiiiiihhhhhh
hhhhhhiiiiiiiiiiiiihhhhhhhhhiiiiiiiiiiiiiiiiiiiiihhhhhhhohhhgghhhhhhrhhhrhiiiiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhiiiiiiiiiiiiiiiihhh
hhhhhhhiiiiiiihhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiiihhhohhhhhhhhhhhrhhhrhhhhiiiiiiiiiiiiiiiiiiiiiiiiihhhhiiiiiiiiiiiiiiiiiiiiiihh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiihhhhohhhhhhhhhhhrhhhhhhhhiiiiiiiiiiiiiiiiiiihhhhhhiiiiiiiiiiiiiiiiiiiiiiiiii
hhhhhhiihhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiihohhhhhhhhhhhhhhhrhhhhhhhiiiiiiiiiiiiihhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiiii
hiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiiihohhhhhhhhhhhrhhhhhhhhhhiiiiiiiihhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiii
iiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiohhhhhhhohhhohhhrhhhhhhhhhiihhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiii
iiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiohhhhhhhohhhrhhhhhhhhhhhihhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiii
iiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiioiihohhhohhhohhhhhhhhiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiii
iiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiioiiihhhhohhhjhiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiii
iiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiioiiioiihohhijiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiii
iiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiioihhhhhioiiijiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiii
iiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiihhhhhohhhohiijiii7iiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiii
iiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhiiiiiiiihhhhhhhhohhhhhhhoiii7iii7iiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiii
iiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhiihhhhhhhhhhhhhhhnhhhohhh7iii7iiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiii
iiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhihhhhhhhhhhhhhhnhhhohhhohhijiii7iiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiii
iiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhiiiiiiiihhhhhhhhhhhhhhnhhhohhh7hhhriiiiiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhhiiii
iiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhiiiiiiiiiiiiihhhhhhhhhhhnhhhohhhohhh7hhi7iiiiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhhiii
iiiiiiiiiiiiiiiiiiiiiihhhhhiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhnhhhnhhh7hhhrhii7iiiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhhii
iiiiiiiiiiiiiiiiiiihhhhhiiiiiiiiiiiiiiiiiiiiiiihhhhhhhhhnhhhnhhhnhhhjhhh7hiiiiiiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hiiiiiiiiiiiiihhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiiiihhhhhhhhhhnhhhnhhhjhhh7hhh7iiiiiiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhhhhhhhii
hhiiiiiiiihhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiiiihhhhhhhnhhhnhhhhhhhjhhh7hhhiiiiiiiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhhhhhhhiiiiii
hhhiihhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiiihhhhhhhhnhhhnhhhjhhhhhhh7hhiiiiiiiiiiiiiiiiiiiiiiiiiiihhhhhhhhhhhhhhiiiiiiiiii

__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000980098009800980098009800980000980000000000000000000000000000000000000000000000000000000000000000
__map__
2424242434343434343434343434343402000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242434343434343434343434343400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242434343434343434343434343400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242434343434343434343434343400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242434343434343434343434343400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3434343434343434343434343434343400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3434343434343434343434343434343400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3434343434343434343434343434343400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3434343434343434343434343434343400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100003265028650226501e6401b640186401564013640126400163000630006300062000720027300475006740097300b7200f720167100061000600006000060000000000000000000000000000000000000
000100002865022650080500605005650046500465003650006400164001630016300163001630016200062000620006100261002610016100160001600006000060000000000000000000000000000000000000
000100001f1600f460226501e63000720136200f6200d6300b6200861002730017200073000710007000070000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100000863002560035100351001510015100151000500005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
