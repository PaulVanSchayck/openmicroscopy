#include <omero/client.h>
#include <iostream>

int main(int argc, char* argv[]) {

    // All configuration in file pointed to by
    // --Ice.Config=file.config
    // No username, password entered
    omero::client1(argc, argv);
    /* client1.createSession(); */

    // Most basic configuration.
    // Uses default port 4063
    // createSession needs username and password
    omero::client2("localhost");
    /* client2.createSession("root", "ome"); */

    // Configuration with port information
    omero::client3("localhost", 24063);
    /* client3.createSession("root", "ome"); */

    // Advanced configuration in C++ takes place
    // via an InitializationData instance.
    Ice::InitializationData data;
    data.properties = Ice::createProperties();
    data.properties->setProperty("omero.host", "localhost");
    omero::client client4(data);
    /* client4.createSession("root", "ome"); */

    // std::map to be added (ticket:1278)
    data.properties->setProperty("omero.user", "root");
    data.properties->setProperty("omero.pass", "ome");
    omero::client client5(data);
    // Again, no username or password needed
    // since present in the data. But they *can*
    // be overridden.
    /* client5.createSession(); */
}
