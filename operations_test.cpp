#include <gtest/gtest.h>

#include "operations.h"

TEST( operations, sum )
{
    EXPECT_EQ( 5, sum(2, 3) );
}

int main(int argc, char *argv[])
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

