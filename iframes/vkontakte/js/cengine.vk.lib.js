
	
	/*************************************************************************************
	*                                   Show payment Box                                 *
	*************************************************************************************/
	
	function showPaymentBox(num)
	{
		VK.callMethod("showPaymentBox", num);
	}
	 
	function onBalanceChanged(e) {
	 
		var obj = getFlashAppObject();
		
		if (obj) {		
			obj.CEngine_PaymentCallback(e);
		}
	}
	
	/*************************************************************************************
	*                               Show invite box                                      *
	*************************************************************************************/
	
	function showInviteBox() {
		VK.callMethod('showInviteBox');
	}

	/*************************************************************************************
	*                               Post to User Wall                                    *
	*************************************************************************************/
	
	function CEngine_saveWallPost(hash)
	{
		VK.addCallback("onWallPostSave", onWallPostSave); 		
		VK.addCallback("onWallPostCancel", onWallPostCancel); 
		
		VK.callMethod("saveWallPost", hash);		
	}
	
	function onWallPostCancel()
	{
		var obj = getFlashAppObject();
		if(obj){
			obj.CEngine_PostWallCallback(false);
		}
		
		VK.removeCallback("onWallPostCancel", onWallPostCancel);
		VK.removeCallback("onWallPostSave", onWallPostSave);
	}
	
	function onWallPostSave()
	{
		var obj = getFlashAppObject();
		if(obj){
			obj.CEngine_PostWallCallback(true);
		}
		
		VK.removeCallback("onWallPostCancel", onWallPostCancel);
		VK.removeCallback("onWallPostSave", onWallPostSave);
	}
	
	/*************************************************************************************
	*                               Post to User News                                    *
	*************************************************************************************/
	
	function CEngine_saveNewsPost(_owner_id, _message, _attachment)
	{
		VK.api("wall.post", {owner_id: _owner_id, message: _message, attachment: _attachment}, function(data){
			
			var obj = getFlashAppObject();
			if(obj){			
				
				if (data.response) 
				{
					obj.CEngine_PostNewsCallback(data.response.post_id, 0);
				}
			}
			
		});	
	}
	
	/*************************************************************************************
	*                    Get Flash Application Object for Callbacks                      *
	*************************************************************************************/
	
	function getFlashAppObject()
	{
		return (navigator.appName.indexOf("Microsoft") != -1) ? window['ApplicationContainer'] : window.document['ApplicationContainer'];
	}
	