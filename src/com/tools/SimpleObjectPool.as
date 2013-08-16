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

        /**
         * The map of allocated object to check them in the free phase.
         */
        protected var allocatedObjects:Dictionary;

        /**
         * The number of allocated objects.
         */
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
        public function free(object:Object):Boolean
        {
            if (isRegistered(object) == true)
            {
                freeObjects[freeObjects.length] = object;
                return true;
            }
            return false;
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
         * Returns allocation state of object.
         * @param object Checking object.
         * @return <code>true</code> if this object was allocated by pool.
         */
        private function isRegistered(object:Object):Boolean
        {
            return allocatedObjects[object] != null;
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