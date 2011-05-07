package app.entity.myfirstentity.components 
{
	import com.mrbee.cengine.base.components.EntityComponent;
	import com.mrbee.cengine.console.logger.Logger;
	
	/**
	 * Базовый компонент
	 * @author Poluosmak Andrew
	 */
	public class FirstBaseComponent extends EntityComponent
	{
		// имя компонента в сущности
		public static const NAME:String = "MyFirstEntityComponents_FirstBaseComponent";
		
		public function FirstBaseComponent() 
		{
			super();						
			Logger.print("FirstBaseComponent Created");
		}
		
		/**
		 * Обработчик вызываемый после успешного добавления компонента в систему. Если данный метод переопределяется в пользовтаельских компонентах, 
		 * то супер метод onAddHandler должен быть вызван перед любыми дополнительными действиями.
		 */
		override public function onAddHandler():void
		{
			super.onAddHandler();			
			Logger.print("FirstBaseComponent added to entity");
			
			initialize();
		}
		
		/**
		 * Обработчик вызываемый перед удалением компонента из системы. Если данный метод оверайдится в пользовтаельских компонентах, 
		 * то супер метод onRemoveHandler должен быть вызван только после осуществления всех дополнительных действий.   
		 */
		override public function onRemoveHandler():void
		{					
			Logger.print("FirstBaseComponent removed from entity");
			super.onRemoveHandler();
		}
		
		//
		public function initialize():void
		{
			// в любом типе компонента всегда доступен сущность родитель owner
			Logger.print("FirstBaseComponent initialize. My owner: "+owner.name);						
		}
		
	}

}