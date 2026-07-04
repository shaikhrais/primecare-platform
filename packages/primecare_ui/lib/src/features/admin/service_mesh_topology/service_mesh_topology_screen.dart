import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/service_mesh_topology_header_section.dart';
import 'sections/service_mesh_topology_filter_bar_section.dart';
import 'sections/service_mesh_topology_data_table_section.dart';
import 'sections/service_mesh_topology_pagination_section.dart';
import 'sections/service_mesh_topology_action_bar_section.dart';

class ServiceMeshTopologyScreen extends StatelessWidget {
  const ServiceMeshTopologyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'service_mesh_topology',
      title: 'Service Mesh Topology',
      child: Column(
        children: const [
          const ServiceMeshTopologyHeaderSection(),
          const ServiceMeshTopologyFilterBarSection(),
          const ServiceMeshTopologyDataTableSection(),
          const ServiceMeshTopologyPaginationSection(),
          const ServiceMeshTopologyActionBarSection(),
        ],
      ),
    );
  }
}
