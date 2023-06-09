ESX = nil

--[[
              Cradit  
            𝕾𝖆𝖎𝖑𝖔𝖒#9455
    อย่าหาขายและก็อย่าลบข้อความนี้ด้วยอุส่านั้งแก้
	แจกได้จะใส่ใน vipก็ได้มันทำง่ายใครขายขอให้แม่งชิบหาย
	ขายสคริปอะไรก็ขอให้หลุด ชีวิตไม่เจริญ

]]

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'gouvernment', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'gouvernment', _U('alert_gouvernment'), true, true)
TriggerEvent('esx_society:registerSociety', 'gouvernment', 'gouvernment', 'society_gouvernment', 'society_gouvernment', 'society_gouvernment', {type = 'public'})

RegisterServerEvent('esx_gouvernmentjob:confiscatePlayerItem')
AddEventHandler('esx_gouvernmentjob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	-- if sourceXPlayer.job.name ~= 'police' then
	-- 	print(('esx_policejob: %s attempted to confiscate!'):format(xPlayer.identifier))
	-- 	return
	-- end
	
	if amount == nil then
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="red-text">ปริมาณที่ไม่ถูกต้อง</strong>',
			type = "error",
			timeout = 3000,
			layout = "centerLeft",
			queue = "global"
		})
		return
	end

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
				TriggerClientEvent("pNotify:SendNotification", target, {
					text = '<strong class="red-text">ปริมาณที่ไม่ถูกต้อง หรือ ช่องเก็บของมีพื้นที่ไม่เพียงพอ</strong>',
					type = "error",
					timeout = 3000,
					layout = "centerLeft",
					queue = "global"
				})
			else
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem(itemName, amount)
				TriggerClientEvent("pNotify:SendNotification", _source, {
					text = 'คุณได้ริบ <strong class="amber-text">'..sourceItem.label..'</strong> จำนวน <strong class="amber-text">'..amount..'</strong> ของคุณ <strong class="blue-text">'..targetXPlayer.name..'</strong> เรียบร้อยแล้ว',
					type = "success",
					timeout = 3000,
					layout = "centerLeft",
					queue = "global"
				})
				TriggerClientEvent("pNotify:SendNotification", target, {
					text = 'บางคน <strong class="amber-text">'..sourceItem.label..'</strong> จำนวน <strong class="amber-text">'..amount..'</strong> ออกจากกระเป๋าคุณ',
					type = "success",
					timeout = 3000,
					layout = "centerLeft",
					queue = "global"
				})
			end
		else
			TriggerClientEvent("pNotify:SendNotification", _source, {
				text = '<strong class="red-text">จำนวนไอเทมไม่ถูกต้อง</strong>',
				type = "error",
				timeout = 3000,
				layout = "centerLeft",
				queue = "global"
			})
		end
	elseif itemType == 'item_money' then
		if amount <= 0 then
			TriggerClientEvent("pNotify:SendNotification", _source, {
				text = '<strong class="red-text">จำนวนที่ไม่ถูกต้อง</strong>',
				type = "error",
				timeout = 3000,
				layout = "centerLeft",
				queue = "global"
			})
		else

			targetXPlayer.removeMoney(amount)
			sourceXPlayer.addMoney (amount)

			TriggerClientEvent("pNotify:SendNotification", _source, {
				text = 'คุณได้ริบ <strong class="amber-text">เงินสด</strong> จำนวน <strong class="amber-text">'..amount..'</strong> ของคุณ <strong class="blue-text">'..targetXPlayer.name..'</strong> เรียบร้อยแล้ว',
				type = "success",
				timeout = 3000,
				layout = "centerLeft",
				queue = "global"
			})
			TriggerClientEvent("pNotify:SendNotification", target, {
				text = 'บางคน <strong class="amber-text">เงินสด</strong> จำนวน <strong class="amber-text">'..amount..'</strong> ออกจากกระเป๋าคุณ',
				type = "success",
				timeout = 3000,
				layout = "centerLeft",
				queue = "global"
			})

		end
	elseif itemType == 'item_account' then
		if amount <= 0 then
			TriggerClientEvent("pNotify:SendNotification", _source, {
				text = '<strong class="red-text">จำนวนที่ไม่ถูกต้อง</strong>'..amount,
				type = "error",
				timeout = 3000,
				layout = "centerLeft",
				queue = "global"
			})
		else

			targetXPlayer.removeAccountMoney(itemName, amount)
			sourceXPlayer.addAccountMoney   (itemName, amount)

			TriggerClientEvent("pNotify:SendNotification", _source, {
				text = 'คุณได้ริบ <strong class="amber-text">'..itemName..'</strong> จำนวน <strong class="amber-text">'..amount..'</strong> ของคุณ <strong class="blue-text">'..targetXPlayer.name..'</strong> เรียบร้อยแล้ว',
				type = "success",
				timeout = 3000,
				layout = "centerLeft",
				queue = "global"
			})
			TriggerClientEvent("pNotify:SendNotification", target, {
				text = 'บางคน <strong class="amber-text">'..itemName..'</strong> จำนวน <strong class="amber-text">'..amount..'</strong> ออกจากกระเป๋าคุณ',
				type = "success",
				timeout = 3000,
				layout = "centerLeft",
				queue = "global"
			})

		end
		
	elseif itemType == "item_key" then -- MEETA GiveKey

		MySQL.Async.execute("UPDATE owned_vehicles SET owner = @newplayer WHERE owner = @identifier AND plate = @plate",
		{
			['@newplayer']		= sourceXPlayer.identifier,
			['@identifier']		= targetXPlayer.identifier,
			['@plate']		= itemName
		})
		
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = 'คุณได้ริบ <strong class="amber-text">กุญแจรถ</strong> ทะเบียน <strong class="yellow-text">'..itemName..'</strong>',
			type = "success",
			timeout = 3000,
			layout = "centerLeft",
			queue = "global"
		})
		TriggerClientEvent("pNotify:SendNotification", target, {
			text = 'บางคน <strong class="amber-text">กุญแจรถ</strong> ทะเบียน <strong class="yellow-text">'..itemName..'</strong> ออกจากกระเป๋าคุณ',
			type = "success",
			timeout = 3000,
			layout = "centerLeft",
			queue = "global"
		})

	elseif itemType == "item_keyhouse" then -- MEETA GiveKeyHouse

		MySQL.Async.execute("UPDATE owned_properties SET owner = @newplayer WHERE owner = @identifier AND id = @id",
		{
			['@newplayer']		= sourceXPlayer.identifier,
			['@identifier']		= targetXPlayer.identifier,
			['@id']		= itemName
		})

		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = 'คุณได้ริบ <strong class="amber-text">กุญแจบ้าน</strong>',
			type = "success",
			timeout = 3000,
			layout = "centerLeft",
			queue = "global"
		})
		TriggerClientEvent("pNotify:SendNotification", target, {
			text = 'บางคน <strong class="amber-text">กุญแจบ้าน</strong> ถูกยึดโดย <strong class="blue-text">'.. sourceXPlayer.name ..'</strong> ออกจากกระเป๋าคุณ',
			type = "success",
			timeout = 3000,
			layout = "centerLeft",
			queue = "global"
		})

	end
end)

RegisterServerEvent('esx_gouvernmentjob:handcuff')
AddEventHandler('esx_gouvernmentjob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.job.name == 'gouvernment' then
		TriggerClientEvent('esx_gouvernmentjob:handcuff', target)
	else
		print(('esx_gouvernmentjob: %s attempted to handcuff a player (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_gouvernmentjob:drag')
AddEventHandler('esx_gouvernmentjob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.job.name == 'gouvernment' then
		TriggerClientEvent('esx_gouvernmentjob:drag', target, source)
	else
		print(('esx_gouvernmentjob: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_gouvernmentjob:putInVehicle')
AddEventHandler('esx_gouvernmentjob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.job.name == 'gouvernment' then
		TriggerClientEvent('esx_gouvernmentjob:putInVehicle', target)
	else
		print(('esx_gouvernmentjob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_gouvernmentjob:OutVehicle')
AddEventHandler('esx_gouvernmentjob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.job.name == 'gouvernment' then
		TriggerClientEvent('esx_gouvernmentjob:OutVehicle', target)
	else
		print(('esx_gouvernmentjob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_gouvernmentjob:getStockItem')
AddEventHandler('esx_gouvernmentjob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_gouvernment', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end
	end)

end)

RegisterServerEvent('esx_gouvernmentjob:putStockItems')
AddEventHandler('esx_gouvernmentjob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_gouvernment', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventoryItem.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

	end)

end)

ESX.RegisterServerCallback('esx_gouvernmentjob:getOtherPlayerData', function(source, cb, target)

	if Config.EnableESXIdentity then

		local xPlayer = ESX.GetPlayerFromId(target)

		local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, sex, dateofbirth, height FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		})

		local firstname = result[1].firstname
		local lastname  = result[1].lastname
		local sex       = result[1].sex
		local dob       = result[1].dateofbirth
		local height    = result[1].height

		local data = {
			name      = GetPlayerName(target),
			job       = xPlayer.job,
			inventory = xPlayer.inventory,
			accounts  = xPlayer.accounts,
			weapons   = xPlayer.loadout,
			firstname = firstname,
			lastname  = lastname,
			sex       = sex,
			dob       = dob,
			height    = height
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end

	else

		--[[
              Cradit  
            𝕾𝖆𝖎𝖑𝖔𝖒#9455
    อย่าหาขายและก็อย่าลบข้อความนี้ด้วยอุส่านั้งแก้
	แจกได้จะใส่ใน vipก็ได้มันทำง่ายใครขายขอให้แม่งชิบหาย
	ขายสคริปอะไรก็ขอให้หลุด ชีวิตไม่เจริญ

]]

		local xPlayer = ESX.GetPlayerFromId(target)

		local data = {
			name       = GetPlayerName(target),
			job        = xPlayer.job,
			inventory  = xPlayer.inventory,
			accounts   = xPlayer.accounts,
			weapons    = xPlayer.loadout
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		TriggerEvent('esx_license:getLicenses', target, function(licenses)
			data.licenses = licenses
		end)

		cb(data)

	end

end)

ESX.RegisterServerCallback('esx_gouvernmentjob:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_gouvernmentjob:getVehicleInfos', function(source, cb, plate)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}

		if result[1] then

			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname
				else
					retrivedInfo.owner = result2[1].name
				end

				cb(retrivedInfo)
			end)
		else
			cb(retrivedInfo)
		end
	end)
end)

function string:split(delimiter)
	local result = { }
	local from  = 1
	local delim_from, delim_to = string.find( self, delimiter, from  )
	while delim_from do
	  table.insert( result, string.sub( self, from , delim_from-1 ) )
	  from  = delim_to + 1
	  delim_from, delim_to = string.find( self, delimiter, from  )
	end
	table.insert( result, string.sub( self, from  ) )
	return result
  end

ESX.RegisterServerCallback('esx_gouvernmentjob:getVehicleByName', function(source, cb, name)
	local FullName = name.split(name," +")
	MySQL.Async.fetchAll('SELECT * FROM users WHERE firstname = @firstname AND lastname = @lastname', {
		['@firstname'] = FullName[1],
		['@lastname'] = FullName[2],
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier',  {
				['@identifier'] = result[1].identifier
			}, function(result2)
				cb(result2, true)
				

			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_gouvernmentjob:getHouseByName', function(source, cb, name)
	local FullName = name.split(name," +")
	MySQL.Async.fetchAll('SELECT * FROM users WHERE firstname = @firstname AND lastname = @lastname', {
		['@firstname'] = FullName[1],
		['@lastname'] = FullName[2],
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE owner = @identifier',  {
				['@identifier'] = result[1].identifier
			}, function(result2)
				cb(result2, true)
				

			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_gouvernmentjob:getVehicleFromPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					cb(result2[1].firstname .. ' ' .. result2[1].lastname, true)
				else
					cb(result2[1].name, true)
				end

			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_gouvernmentjob:getArmoryWeapons', function(source, cb)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_gouvernment', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)

end)

ESX.RegisterServerCallback('esx_gouvernmentjob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)

	local xPlayer = ESX.GetPlayerFromId(_source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_gouvernment', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)

end)

ESX.RegisterServerCallback('esx_gouvernmentjob:removeArmoryWeapon', function(source, cb, weaponName)

	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_gouvernment', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)

end)

ESX.RegisterServerCallback('esx_gouvernmentjob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(_source)
	local authorizedWeapons, selectedWeapon = Config.AuthorizedWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('esx_gouvernmentjob: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
		cb(false)
	end

	-- Weapon
	if type == 1 then
		if xPlayer.getMoney() >= selectedWeapon.price then
			xPlayer.removeMoney(selectedWeapon.price)
			xPlayer.addWeapon(weaponName, 100)

			cb(true)
		else
			cb(false)
		end

	-- Weapon Component
	elseif type == 2 then
		local price = selectedWeapon.components[componentNum]
		local weaponNum, weapon = ESX.GetWeapon(weaponName)

		local component = weapon.components[componentNum]

		if component then
			if xPlayer.getMoney() >= price then
				xPlayer.removeMoney(price)
				xPlayer.addWeaponComponent(weaponName, component.name)

				cb(true)
			else
				cb(false)
			end
		else
			print(('esx_gouvernmentjob: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
			cb(false)
		end
	end
end)


ESX.RegisterServerCallback('esx_gouvernmentjob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('esx_gouvernmentjob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
			['@owner'] = xPlayer.identifier,
			['@vehicle'] = json.encode(vehicleProps),
			['@plate'] = vehicleProps.plate,
			['@type'] = type,
			['@job'] = xPlayer.job.name,
			['@stored'] = true
		}, function (rowsChanged)
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_gouvernmentjob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(_source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('esx_gouvernmentjob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end

end)

function getPriceFromHash(hashKey, jobGrade, type)
	if type == 'helicopter' then
		local vehicles = Config.AuthorizedHelicopters[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]
		local shared = Config.AuthorizedVehicles['Shared']

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end

		for k,v in ipairs(shared) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

ESX.RegisterServerCallback('esx_gouvernmentjob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_gouvernment', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_gouvernmentjob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(_source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source
	
	--[[
              Cradit  
            𝕾𝖆𝖎𝖑𝖔𝖒#9455
    อย่าหาขายและก็อย่าลบข้อความนี้ด้วยอุส่านั้งแก้
	แจกได้จะใส่ใน vipก็ได้มันทำง่ายใครขายขอให้แม่งชิบหาย
	ขายสคริปอะไรก็ขอให้หลุด ชีวิตไม่เจริญ

]]
	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)
		
		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'gouvernment' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_gouvernmentjob:updateBlip', -1)
		end
	end	
end)

RegisterServerEvent('esx_gouvernmentjob:spawned')
AddEventHandler('esx_gouvernmentjob:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'gouvernment' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_gouvernmentjob:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_gouvernmentjob:forceBlip')
AddEventHandler('esx_gouvernmentjob:forceBlip', function()
	TriggerClientEvent('esx_gouvernmentjob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_gouvernmentjob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'gouvernment')
	end
end)

RegisterServerEvent('esx_gouvernmentjob:message')
AddEventHandler('esx_gouvernmentjob:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)

--[[
              Cradit  
            𝕾𝖆𝖎𝖑𝖔𝖒#9455
    อย่าหาขายและก็อย่าลบข้อความนี้ด้วยอุส่านั้งแก้
	แจกได้จะใส่ใน vipก็ได้มันทำง่ายใครขายขอให้แม่งชิบหาย
	ขายสคริปอะไรก็ขอให้หลุด ชีวิตไม่เจริญ

]]