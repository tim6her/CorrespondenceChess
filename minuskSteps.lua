-- minuskSteps.lua

-- xskak-commands
function getMinuskSteps(movenr,nextplayer,info,k,default)

	if nextplayer == "w" then
		local white=1
	else
		white=0
	end
	
	local totalSteps=(movenr-1)*2+white
	if (k<0 or k >= totalSteps) then
		tex.sprint(default)
	else
		tex.sprint("\\xskakset{stepmoveid=-",k,"}","\\xskakget{",info,"}%")
	end

end

function getgameMinuskSteps(movenr,nextplayer,info,k,default)

	if nextplayer == "w" then
		local white=1
	else
		white=0
	end
	
	local totalSteps=(movenr-1)*2+white
	if (k<0 or k >= totalSteps) then
		tex.sprint(default)
	else
		tex.sprint("\\xskakset{stepmoveid=-",k,"} \\xskakgetgame{",info,"}%")
	end

end

-- time differences
function lastDayDifferenceFromStrings(datestring1,datestring2,player,default)

	local dates1 = string2array(datestring1)
	local dates2 = string2array(datestring2)
	numDates1 = dates1[0]
	numDates2 = dates2[0]
	
	if ( numDates1*numDates2 == 0 or numDates1 ~= numDates2 ) then
		return default
	else
		local n = numDates1

		if player == "1" then
			return daysBetweenFromString(dates1[n],dates2[n])
		else
			if n == 1 then
				return default
			else
				return daysBetweenFromString(dates1[n-1],dates2[n])
			end
		end
	end
end

function totalRespiteFromString(datestring1,datestring2,player,default)
	
	local dates1 = string2array(datestring1)
	local dates2 = string2array(datestring2)
	numDates1 = dates1[0]
	numDates2 = dates2[0]
	
	if ( numDates1*numDates2 == 0 or numDates1 ~= numDates2 ) then
		return default
	else
		local n = numDates1
		local respite = 0

		if player == "1" then
			local i = 1
			while i <= n do
				respite = respite + daysBetweenFromString(dates1[i],dates2[i])
				i = i + 1
			end 
		else
			if n == 1 then
				return default
			else
				local i = 1
				while i <= n do
					respite = respite + daysBetweenFromString(dates1[i-1],dates2[i])
					i = i + 1
				end 
			end
		end
		
		return respite
	end
end

function lastDate(datestring,default)
	
	local dates = string2array(datestring)
	numDates = dates[0]

	if numDates1 == 0 then
		return default
	else
		local ret = dates[numDates]
		if ret == "nil" then
			return default
		else
			return ret
		end
	end
end

function daysBetweenFromString(date1,date2)
	if ( date1 == "nil" or date2 == "nil") then
		return 0
	else
		local day1=makeTimeStamp(date1)
		local day2=makeTimeStamp(date2)
		
		return daysBetween(day1,day2)
	end
end

function daysBetween(date1,date2)
	return (date2-date1)/86400
end

function makeTimeStamp(dateString)
    local pattern = "(%d+)%.(%d+)%.(%d+)"
    local xday, xmonth, xyear = dateString:match(pattern)
    convertedTimestamp = os.time({year = xyear, month = xmonth, day = xday, hour=1, minute=0, second=0})
	
    return convertedTimestamp
end

function string2array(string)
	local space = "%g+"
	
	array = {}
	local i=1
	for v in string.gmatch(string, space) do
	       array[i] = v
		   i=i+1
	end
	array[0]=i-1
	return array
end