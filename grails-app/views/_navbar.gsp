
         
              <div class="ui container">
	              <g:link action="index">
	                <div href="#" class="header item">
	                  <img class="logo" src="${resource(dir: 'images', file: 'gameplifylogo.png')}"/>
	                  GAMEPLIFY 
	                </div>
	               </g:link>
              </div>
              <g:if test="${session?.user?.role == "Admin"}">
		              <div class = "header item">
		              	Game
		              </div>
		              <div class = "header item">
		              	User
		              </div>
	          </g:if>
                <div class="ui search">
                      <div class="ui icon input">
                        <input class="prompt" type="text" placeholder="Search games...">
                        <i class="search icon"></i>
                      </div>
                      <div class="results"></div>
                </div>
                 <div id="demo_box">
            <span class="pop_ctrl"><img id= "navi" src="${resource(dir: 'icons', file: 'nav.png')}"></span>
            <ul id="demo_ul">
            	
				<g:each in="${categories}" status="i" var="cat">				 	
	                <li class="demo_li"><g:link action="listGame" params="${[categoryName: cat.categoryName]}"><img id= "icon" src="${resource(dir: 'icons', file: "${cat.icon}")}"><div>${cat.categoryName}</div></g:link></li>                	
                </g:each>
				
           		
            </ul>
        </div>
       
       
        
        <script src="${resource(dir:'js', file:'jquery.min.js')}"></script>
    <script src="${resource(dir:'js', file:'jquery.popmenu.js')}"></script>
    <script>
        $(function(){
            $('#demo_box').popmenu();
        })
    </script>
       

