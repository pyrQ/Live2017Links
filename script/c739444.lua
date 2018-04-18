--マガジンドラムゴン
--Vorticular Drumgon
function c739444.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c739444.matfilter,3,3)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(739444,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,739444)
	e1:SetTarget(c739444.drtg)
	e1:SetOperation(c739444.drop)
	c:RegisterEffect(e1)
	--disable field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c739444.discon)
	e2:SetOperation(c739444.disop)
	c:RegisterEffect(e2)
end
function c739444.matfilter(c,scard,sumtype,tp)
	return c:IsRace(RACE_DRAGON,scard,sumtype,tp) and c:IsAttribute(ATTRIBUTE_DARK,scard,sumtype,tp)
end
function c739444.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c739444.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	e:GetHandler():RegisterFlagEffect(739444,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
end
function c739444.discon(e)
	return e:GetHandler():GetFlagEffect(739444)~=0
end
function c739444.disop(e,tp)
	local c=e:GetHandler()
	local flag1=bit.band(c:GetLinkedZone(tp),0xff00ffff)
	local flag2=bit.band(c:GetLinkedZone(1-tp),0xff00ffff)
	return flag1+flag2
end

