#include <gtest/gtest.h>

#include "operations.h"

TEST( operations, sum )
{
    EXPECT_EQ( 5, sum(2, 3) );
}

TEST( operations, minus )
{
    EXPECT_EQ( 1, minus(3, 2) );
}

int main(int argc, char *argv[])
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

