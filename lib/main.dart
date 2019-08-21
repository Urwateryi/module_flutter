import 'package:flutter/material.dart';
import 'package:module_flutter/base/view_model_provider.dart';
import 'package:module_flutter/biz/view/choose_brand_view_model.dart';
import 'biz/view/choose_brand_page2.dart';

void main() => runApp(MaterialApp(
      home: ViewModelProvider(
        viewModel: ChooseBrandViewModel(),
        child: ChooseBrandPage2(),
      ),
    ));
