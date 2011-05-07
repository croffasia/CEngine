package app.entity.myfirstentity 
{
	import app.entity.myfirstentity.components.FirstBaseComponent;
	import com.mrbee.cengine.console.logger.Logger;
	import com.mrbee.cengine.core.CEntity;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	public class MyFirstEntity extends CEntity
	{
		// уникальное имя сущности, по которому она будет доступна в системе
		public static const NAME:String = "MyFirstEntity";
		
		public function MyFirstEntity() 
		{
			super();
			
			// назначем имя
			name = NAME;
			
			// регистрируем сущность в системе
			registerEntity();
			
			Logger.print("MyFirstEntity Created");			
			
			configureComponents();
		}
		
		/**
		 * Конфигурируем компоненты, которые необходимы для работы сущности
		 */
		private function configureComponents():void
		{
			/**
			 * Добавляя компоненты, не оставляйте ссылок на них. Это позволяет ислючить лишние ссылки на объекты.
			 * К любому компоненту системы в любой сущности можно обратиться посредством PropertyReference
			 * Если же вам нужно обратиться из одного компонента в другой в рамках обной сущности, то вы можете 
			 * использовать owner.getComponentByName() owner.getComponentByType() непосресдтвенно в самом компоненте. 
			 */
			var _firstBaseComponent:FirstBaseComponent = new FirstBaseComponent();
				
				// функцияa ddComponent добавляет компонент в текущую сущность с указаннум именем.
				// имена компонентов выносите в сам компонент в виде публичной статиеской константы NAME
				addComponent(FirstBaseComponent.NAME, _firstBaseComponent);
								
		}
		
	}

}