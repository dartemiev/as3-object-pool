package com.tools
{
    public interface IObjectPool
    {
        /**
         * Allocate object (freed before or created) and register it in pool.
         * @return Instance of object with expected class definition.
         */
        function allocate():*;

        /**
         * Frees object to re-use it in next allocation phase.
         * @param object The instance of object to free it for re-use in next allocation phase.
         */
        function free(object:Object):void;

        /**
         * Returns number of objects free to use in next allocation phase.
         */
        function get freedCount():int;

        /**
         * Returns number of allocated objects.
         */
        function get allocatedCount():int;
    }
}