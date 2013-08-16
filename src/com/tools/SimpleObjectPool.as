package com.tools
{
    import flash.utils.Dictionary;

    public class SimpleObjectPool implements IObjectPool
    {
        protected var DefinitionClass:Class;

        /**
         * The list of freed objects and ready to use them in next allocation phase.
         */
        protected var freeObjects:Vector.<Object>;

        protected var allocatedObjects:Dictionary;

        private var _allocatedCount:int;

        /**
         * Creates new instance of SimpleObjectPool.
         * @param definitionClass Class definition by each allocated and disposed object.
         */
        public function SimpleObjectPool(definitionClass:Class)
        {
            DefinitionClass = definitionClass;

            allocatedObjects = new Dictionary(true);
            freeObjects = new <Object>[];
        }

        /**
         * @inheritDoc
         */
        public function allocate():*
        {
            if (freeObjects.length != 0)
            {
                return freeObjects.pop();
            }
            return register();
        }

        /**
         * @inheritDoc
         */
        public function free(object:Object):void
        {
            freeObjects[freeObjects.length] = object;
        }

        /**
         * Allocate and register new object.
         * @return New registered object.
         */
        protected function register():Object
        {
            var instance:Object = new DefinitionClass();
            allocatedObjects[instance] = instance;
            _allocatedCount++;
            return instance;
        }

        /**
         * @inheritDoc
         */
        public function get freedCount():int
        {
            return freeObjects.length;
        }

        /**
         * @inheritDoc
         */
        public function get allocatedCount():int
        {
            return _allocatedCount;
        }
    }
}