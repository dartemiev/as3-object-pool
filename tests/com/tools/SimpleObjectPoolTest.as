package com.tools
{
    import flash.display.Sprite;
    import flash.geom.Rectangle;

    import org.flexunit.Assert;

    public class SimpleObjectPoolTest
    {
        private var pool:SimpleObjectPool;

        [Before]
        public function setUp()
        {
            pool = new SimpleObjectPool(Sprite);
        }

        [Test]
        /**
         * Test case :
         *   - allocate one object from pool.
         */
        public function testAllocateObject():void
        {
            var sprite:Sprite = pool.allocate();
            Assert.assertNotNull(sprite);
            Assert.assertTrue(sprite is Sprite);
            Assert.assertEquals(pool.allocatedCount, 1);
        }

        [Test]
        /**
         * Test case :
         *   - allocate one object from pool and wrong class definition.
         */
        public function testAllocateWrongObject():void
        {
            try
            {
                Rectangle(pool.allocate());
                Assert.assertTrue(false);
            }
            catch (ex:Error)
            {
                Assert.assertTrue(true);
            }
        }

        [Test]
        /**
         * Test case :
         *   - allocate one object from pool.
         *   - free created object to pool
         *   - allocate one object from pool - it should be previous one.
         */
        public function testDisposeObject():void
        {
            var sprite:Sprite = pool.allocate();
            sprite.name = "sprite";
            Assert.assertEquals(pool.allocatedCount, 1);
            Assert.assertEquals(pool.freedCount, 0);

            pool.free(sprite);
            Assert.assertEquals(pool.allocatedCount, 1);
            Assert.assertEquals(pool.freedCount, 1);

            sprite = pool.allocate();
            Assert.assertNotNull(sprite);
            Assert.assertEquals(sprite.name, "sprite");
            Assert.assertEquals(pool.allocatedCount, 1);
            Assert.assertEquals(pool.freedCount, 0);
        }
    }
}