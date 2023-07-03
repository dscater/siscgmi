<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Modelo Deterministico - Cáculo de Parametros</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row pl-1 pr-1">
                    <div class="col-md-4 pl-0 pr-0">
                        <router-link
                            v-if="
                                permisos.includes(
                                    'modelo_deterministicos.index'
                                )
                            "
                            :to="{
                                name: 'modelo_deterministicos.index',
                            }"
                            class="btn btn-info btn-flat btn-block border-white"
                        >
                            <i class="fa fa-arrow-left"></i>
                            Volver a Modelo Deterministico
                        </router-link>
                    </div>

                    <div class="col-md-4 pl-0 pr-0">
                        <router-link
                            v-if="
                                permisos.includes(
                                    'modelo_deterministicos.modelo_repuestos'
                                )
                            "
                            :to="{
                                name: 'modelo_deterministicos.modelo_repuestos',
                            }"
                            class="btn btn-primary btn-flat btn-block border-white"
                        >
                            <i class="fa fa-list-alt"></i>
                            Modelo Deterministico de Repuestos
                        </router-link>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="form-group col-md-12">
                                        <label
                                            :class="{
                                                'text-danger':
                                                    errors.repuesto_id,
                                            }"
                                            >Seleccionar Repuesto*</label
                                        >

                                        <el-select
                                            class="w-100"
                                            :class="{
                                                'is-invalid':
                                                    errors.repuesto_id,
                                            }"
                                            v-model="datos.repuesto_id"
                                            filterable
                                            placeholder="Repuesto/Equipo de protección"
                                            clearable
                                            @change="getModelos"
                                        >
                                            <el-option
                                                v-for="item in listRepuestos"
                                                :key="item.id"
                                                :value="item.id"
                                                :label="
                                                    item.codigo +
                                                    ' | ' +
                                                    item.nombre +
                                                    ' | ' +
                                                    item.descripcion
                                                "
                                            >
                                            </el-option>
                                        </el-select>
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.repuesto_id"
                                            v-text="errors.repuesto_id[0]"
                                        ></span>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Costo por Ordenar</label>
                                        <input
                                            type="number"
                                            class="form-control"
                                            v-model="datos.co"
                                            readonly
                                        />
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Costo de Adquisición</label>
                                        <input
                                            type="number"
                                            class="form-control"
                                            v-model="datos.cv"
                                            readonly
                                        />
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Costo de Mantenimiento</label>
                                        <input
                                            type="number"
                                            class="form-control"
                                            v-model="datos.cm"
                                            readonly
                                        />
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Lead Time</label>
                                        <input
                                            type="number"
                                            class="form-control"
                                            v-model="datos.lt"
                                            readonly
                                        />
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Unidad de Tiempo</label>
                                        <input
                                            type="number"
                                            class="form-control"
                                            v-model="datos.u"
                                            readonly
                                        />
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Demanda Pronosticada</label>
                                        <input
                                            type="number"
                                            class="form-control"
                                            v-model="datos.d"
                                            readonly
                                        />
                                    </div>
                                </div>
                                <div class="row" v-if="oModeloRepuesto">
                                    <div class="col-md-12 alert alert-info">
                                        <p class="mb-0">
                                            <strong
                                                >Modelo de Repuesto de los Años
                                                y Trimestres:
                                            </strong>
                                            <span
                                                >{{ oModeloRepuesto.anio_ini }}
                                                -
                                                {{
                                                    oModeloRepuesto.trimestre_ini
                                                }}
                                                |
                                                {{ oModeloRepuesto.anio_fin }} -
                                                {{
                                                    oModeloRepuesto.trimestre_fin
                                                }}</span
                                            >
                                        </p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <p>
                                            <strong
                                                >Cálculo de tasa de demanda:
                                            </strong>
                                            <span v-text="calculos.r"></span>
                                        </p>
                                        <p>
                                            <strong
                                                >Cálculo del tiempo de ciclo del
                                                inventario:
                                            </strong>
                                            <span v-text="calculos.t2"></span>
                                        </p>
                                        <p>
                                            <strong
                                                >Cálculo de la cantidad optima a
                                                comprar:
                                            </strong>
                                            <span v-text="calculos.q"></span>
                                        </p>
                                        <p>
                                            <strong
                                                >Cálculo del costo total
                                                promedio:
                                            </strong>
                                            <span v-text="calculos.c_t"></span>
                                        </p>
                                        <p>
                                            <strong
                                                >Cálculo del costo total anual
                                                optimo:
                                            </strong>
                                            <span v-text="calculos.ct"></span>
                                        </p>
                                        <p>
                                            <strong
                                                >Cálculo del costo total anual
                                                real:
                                            </strong>
                                            <span v-text="calculos.cta"></span>
                                        </p>
                                        <p>
                                            <strong
                                                >Cálculo cantidad de ciclo en el
                                                periodo:
                                            </strong>
                                            <span v-text="calculos.n"></span>
                                        </p>
                                        <p>
                                            <strong
                                                >Cálculo del punto de reorden:
                                            </strong>
                                            <span
                                                v-text="calculos.reorden"
                                            ></span>
                                        </p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <button
                                            class="btn btn-primary btn-block"
                                            :disabled="generando || sin_modelos"
                                            @click.prevent="realizaCalculos()"
                                        >
                                            <i
                                                class="fa fa-square-root-alt"
                                            ></i>
                                            <span v-text="btnTexto"></span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
export default {
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            datos: {
                repuesto_id: "",
                co: "",
                cv: "",
                cm: "",
                lt: "",
                u: 4,
                d: "",
            },
            listRepuestos: [],
            errors: [],
            oModeloDeterministico: null,
            oModeloRepuesto: null,
            calculos: {
                r: 0,
                t2: 0,
                q: 0,
                c_t: 0,
                ct: 0,
                cta: 0,
                n: 0,
                reorden: 0,
                l: 0,
            },
            generando: false,
            sin_modelos: true,
        };
    },
    computed: {
        btnTexto() {
            if (this.generando) {
                return "GENERANDO...";
            }
            return "GENERAR";
        },
    },
    mounted() {
        this.loadingWindow.close();
        this.getRepuestos();
        this.getModelos();
    },
    methods: {
        getRepuestos() {
            axios.get("/admin/repuestos").then((response) => {
                this.listRepuestos = response.data.repuestos;
            });
        },
        getModelos() {
            if (this.datos.repuesto_id != "") {
                axios
                    .get(
                        "/admin/modelo_deterministicos/getModelos/" +
                            this.datos.repuesto_id
                    )
                    .then((response) => {
                        this.sin_modelos = false;
                        this.oModeloDeterministico =
                            response.data.modelo_deterministico;
                        this.oModeloRepuesto = response.data.modelo_repuesto;
                        if (
                            this.oModeloDeterministico &&
                            this.oModeloRepuesto
                        ) {
                            this.datos.co =
                                this.oModeloDeterministico.c_ordenar;
                            this.datos.cv = this.oModeloDeterministico.c_adqui;
                            this.datos.cm =
                                this.oModeloDeterministico.c_mantenimiento;
                            this.datos.lt = this.oModeloDeterministico.leadtime;
                            this.datos.u = 4;
                            this.datos.d = this.oModeloRepuesto.demanda;
                        }
                        if (!this.oModeloDeterministico) {
                            Swal.fire({
                                icon: "info",
                                title: "Cálculo faltante",
                                html: `No se encontró el cálculo de <strong>MODELO DETERMINISTICO</strong> para el Repuesto que seleccionó`,
                                showConfirmButton: false,
                            });
                            this.sin_modelos = true;
                        }
                        if (!this.oModeloRepuesto) {
                            Swal.fire({
                                icon: "info",
                                title: "Cálculo faltante",
                                html: `No se encontró el cálculo de <strong>MODELO DETERMINISTICO DE REPUESTO</strong> para el registro que seleccionó`,
                                showConfirmButton: false,
                            });
                            this.sin_modelos = true;
                        }
                    });
            } else {
            }
        },
        // co
        // cv
        // cm
        // lt
        // u
        // d
        realizaCalculos() {
            this.generando = true;
            if (this.datos.d && this.datos.u) {
                this.calculos.r = this.datos.d * this.datos.u;
                if (this.datos.co && this.datos.cm) {
                    this.calculos.t2 = Math.sqrt(
                        (2 * this.datos.co) / (this.calculos.r * this.datos.cm)
                    );

                    this.calculos.q = Math.sqrt(
                        (2 * this.calculos.r * this.datos.co) / this.datos.cm
                    );

                    this.calculos.c_t = Math.sqrt(
                        2 * this.calculos.r * this.datos.cm * this.datos.co
                    );

                    this.calculos.ct =
                        this.calculos.c_t + this.datos.cv * this.calculos.r;
                    this.calculos.cta = this.calculos.ct * this.datos.u;
                    this.calculos.n = this.calculos.r / this.calculos.q;
                    this.calculos.l = this.datos.lt / 90;
                    this.calculos.reorden = this.datos.d * this.calculos.l;

                    this.calculos.r = parseFloat(this.calculos.r).toFixed(2);
                    this.calculos.t2 = parseFloat(this.calculos.t2).toFixed(2);
                    this.calculos.q = parseFloat(this.calculos.q).toFixed(2);
                    this.calculos.c_t = parseFloat(this.calculos.c_t).toFixed(
                        2
                    );
                    this.calculos.ct = parseFloat(this.calculos.ct).toFixed(2);
                    this.calculos.cta = parseFloat(this.calculos.cta).toFixed(
                        2
                    );
                    this.calculos.n = parseFloat(this.calculos.n).toFixed(2);
                    this.calculos.reorden = parseFloat(
                        this.calculos.reorden
                    ).toFixed(2);
                    this.calculos.l = parseFloat(this.calculos.l).toFixed(2);
                } else {
                    this.reiniciaCalculos();
                }
            } else {
                this.reiniciaCalculos();
            }
            this.generando = false;
        },
        reiniciaCalculos() {
            this.calculos = {
                r: 0,
                t2: 0,
                q: 0,
                c_t: 0,
                ct: 0,
                cta: 0,
                n: 0,
                reorden: 0,
                l: 0,
            };
        },
    },
};
</script>

<style></style>
